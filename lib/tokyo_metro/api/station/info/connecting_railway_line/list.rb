# 乗り換え可能路線の一覧を扱うクラス
class TokyoMetro::Api::Station::Info::ConnectingRailwayLine::List < ::TokyoMetro::Api::MetaClass::Fundamental::List

  include ::TokyoMetro::ApiModules::List::Seed

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 0 )
  end

  alias :__seed__ :seed

  def seed( station_id , station_same_as , indent: 0 )
    define_consts_for_seeding
    # 配列の処理 ここから
    self.each do | railway_line_same_as |
      # unless 文 ここから
      unless ignore_when_seed( station_same_as , railway_line_same_as )
        railway_lines = seed__railway_line_name_aliases( station_same_as , railway_line_same_as )
        railway_lines.each do | railway_line |
          railway_line_id = ::RailwayLine.find_by_same_as( railway_line ).id
          ::ConnectingRailwayLine.create(
            station_id: station_id ,
            railway_line_id: railway_line_id
          )
        end
      end
      # unless 文 ここまで
    end
    # 配列の処理 ここまで
  end

  def seed_optional_infos( station_id , station_same_as )
    seed_optional_railway_line_infos_in_a_station( station_id , station_same_as )
    seed_new_railway_line_infos_in_a_station( station_id , station_same_as )
    seed_index_of_railway_lines_in_a_station( station_id , station_same_as )
    seed_additional_transfer_infos_of_railway_lines_in_a_station( station_id , station_same_as )
  end

  private

  def define_consts_for_seeding
    [
      :ignored_railway_lines , :connecting_railway_line_aliases , :optional_railway_lines ,
      :new_railway_lines , :index_in_a_station , :additional_transfer_infos
    ].each do | file_name |
      const_name = file_name.upcase
      unless self.class.constants.include?( const_name )
        self.class.const_set( const_name , ::YAML.load_file( "#{ ::TokyoMetro::DICTIONARY_DIR }/additional_datas/connecting_railway_lines/#{ file_name.to_s }.yaml" ) )
      end
    end
  end

  # データベースに流し込まない（流し込みの際に無視する）設定を行うメソッド
  def ignore_when_seed( station_same_as , railway_line_same_as )
    ignored_railway_line = IGNORED_RAILWAY_LINES.find { | item |
      item[ "stations" ].include?( station_same_as ) and item[ "railway_lines" ].include?( railway_line_same_as )
    }
    ignored_railway_line.present?
  end

  def seed__railway_line_name_aliases( station_same_as , railway_line_same_as )
    connecting_railway_line_alias = CONNECTING_RAILWAY_LINE_ALIASES.find { | item |
      item[ "railway_line" ] == railway_line_same_as and item[ "stations" ].include?( station_same_as )
    }
    unless connecting_railway_line_alias.nil?
      connecting_railway_line_alias[ "railway_line_aliases" ]
    else
      [ railway_line_same_as ]
    end
  end

  def seed_optional_railway_line_infos_in_a_station( station_id , station_same_as )
    info_of_optional_railway_lines = OPTIONAL_RAILWAY_LINES.select { | item |
      item[ "stations" ].include?( station_same_as )
    }
    if info_of_optional_railway_lines.present?
      info_of_optional_railway_lines.map { | info | info[ "railway_lines" ] }.flatten.each do | railway_line |
        railway_line_id = ::RailwayLine.find_by( same_as: railway_line ).id
        ::ConnectingRailwayLine.create( station_id: station_id , railway_line_id: railway_line_id )
      end
    end
  end

  def seed_new_railway_line_infos_in_a_station( station_id , station_same_as )
    info_of_new_railway_lines = NEW_RAILWAY_LINES.select { | item |
      item[ "stations" ].include?( station_same_as )
    }
    if info_of_new_railway_lines.present?
      info_of_new_railway_lines.each do | info_of_new_railway_line |
        new_railway_line = info_of_new_railway_line[ "railway_line" ]
        new_railway_line_id = ::RailwayLine.find_by( same_as: new_railway_line ).id
        ::ConnectingRailwayLine.create( station_id: station_id , railway_line_id: new_railway_line_id )
      end
    end
  end

  def seed_index_of_railway_lines_in_a_station( station_id , station_same_as )
    # この駅の乗換路線情報
    info_of_index = INDEX_IN_A_STATION.find { | item | item[ "station" ] == station_same_as }
    if info_of_index.present?
      # この駅の乗換路線情報（YAMLから、「路線と index を格納したハッシュ」の配列）
      info_of_index_of_railway_lines_in_a_station = info_of_index[ "railway_lines" ]
      # この駅の乗換路線情報（DBから）
      connecting_railway_line_infos = ::ConnectingRailwayLine.where( station_id: station_id )

      connecting_railway_line_infos.each do | connecting_railway_line_info_of_a_railway_line |
        railway_line_id = connecting_railway_line_info_of_a_railway_line.railway_line_id
        railway_line_same_as = ::RailwayLine.find( railway_line_id ).same_as
        info_of_a_railway_line = info_of_index_of_railway_lines_in_a_station.find { | item | item[ "railway_line" ] == railway_line_same_as }
        while info_of_a_railway_line.nil?
          puts "Error: #{station_same_as} / #{railway_line_same_as}"
          railway_line_same_as = gets.chomp
          info_of_a_railway_line = info_of_index_of_railway_lines_in_a_station.find { | item | item[ "railway_line" ] == railway_line_same_as }
        end
        h = {
          index_in_station: info_of_a_railway_line[ "index_in_station" ] ,
          clear: info_of_a_railway_line[ "clear" ]
        }
        connecting_railway_line_info_of_a_railway_line.update(h)
      end

    end
  end

  def seed_additional_transfer_infos_of_railway_lines_in_a_station( station_id , station_same_as )
    additional_transfer_infos = ADDITIONAL_TRANSFER_INFOS.select { | item |
      item[ "stations" ].include?( station_same_as )
    }
    # puts "●station: #{station_same_as}"
    if additional_transfer_infos.present?
      additional_transfer_infos.each do | additional_info |
        railway_lines = additional_info[ "railway_lines" ]
        railway_lines.each do | railway_line_info |
          railway_line_same_as = railway_line_info[ "railway_line" ]
          # puts "railway_line: #{railway_line_same_as}"
          railway_line_id = ::RailwayLine.find_by( same_as: railway_line_same_as ).id
          connecting_railway_line = ::ConnectingRailwayLine.find_by( station_id: station_id , railway_line_id: railway_line_id )
          if connecting_railway_line.nil?
            raise "Error: #{ station_same_as } / #{::RailwayLine.find_by_id( railway_line_id ).same_as}"
          end
          another_station_id = seed_additional_transfer_infos_of_railway_lines_in_a_station__another_station_id( railway_line_info , railway_line_id )
          note_id = seed_additional_transfer_infos_of_railway_lines_in_a_station__note_id( railway_line_info )
          h = {
            not_recommend: railway_line_info[ "not_recommend" ] ,
            another_station_id: another_station_id ,
            connecting_railway_line_note_id: note_id
          }
          connecting_railway_line.update(h)
        end
      end
    end
  end

  def seed_additional_transfer_infos_of_railway_lines_in_a_station__another_station_id( railway_line_info , railway_line_id )
    another_station = railway_line_info[ "another_station" ]
    if another_station.present?
      ::Station.find_by( railway_line_id: railway_line_id , same_as: another_station ).id
    else
      nil
    end
  end

  def seed_additional_transfer_infos_of_railway_lines_in_a_station__note_id( railway_line_info )
    note = railway_line_info[ "note" ]
    if note.present?
      ::ConnectingRailwayLineNote.find_or_create_by( note: note ).id
    else
      nil
    end
  end

end