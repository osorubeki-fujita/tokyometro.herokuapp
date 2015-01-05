class TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternA::TrainTypeFactory < TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactory

  @patterns = ::Array.new

  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::CurrentStation
  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::ConvertRailwayLine

  def initialize( train_type_same_as , railway_line_instance , terminal_station_instance , operation_day_instance , station_instance )
    puts "Terminal Station: " + terminal_station_instance.same_as
    super( train_type_same_as , railway_line_instance , terminal_station_instance , operation_day_instance )
    @station_instance = station_instance
  end

  def to_a
    super + [ @station_instance.id ]
  end

  def self.train_type_pattern_class
    ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternA::TrainTypeFactory::Pattern
  end

  private

  # 南北線内の都営三田線の列車か否かを判定するメソッド
  # @return [Boolean]
  # @note 上位クラスのメソッドを上書きしている。
  def toei_mita_line_train_in_namboku_line?
    super and at_namboku_and_toei_mita_common_station?
  end

  # 有楽町線・副都心線の列車種別を取得するメソッド
  # @return [TrainType(s)]
  # @note 上位クラスのメソッドを上書きしている。
  def yurakucho_and_fukutoshin_train_type
    #-------- 「休日急行」（明治神宮前に停車）対策
    process_holiday_express_of_fukutoshin_line

    #-------- 列車種別（API）の取得
    train_type_in_api_instance = ::TrainTypeInApi.find_by_same_as( @train_type_same_as )

    #-------- 有楽町線・副都心線の単独区間の駅の場合
    if !( at_yurakucho_and_fukutoshin_common_station? )
      h = {
        railway_line_id: @railway_line_instance.id ,
        train_type_in_api: train_type_in_api_instance.id
      }
      train_types = ::TrainType.where(h).select { | train_type | train_type.normal? }

    #-------- 有楽町線・副都心線の共用区間の駅の場合

    #-------- 小竹向原から和光市方面に行く場合 or 西武線方面へ行く場合
    elsif ( is_terminating_on_tobu_tojo_line? or is_terminating_at_wakoshi? ) or is_terminating_on_seibu_line?
      # 「有楽町線急行」「有楽町線通勤急行」対策
      process_railway_line_of_between_wakoshi_and_kotake_mukaihara

      h = {
        railway_line_id: @railway_line_instance.id ,
        train_type_in_api: train_type_in_api_instance.id
      }
      train_types = ::TrainType.where(h).select { | train_type | train_type.normal? }
      puts train_types.to_s

    else
      train_types = select_train_types_to_yurakucho_fukutoshin_or_tokyu_mm_line( train_type_in_api_instance )
    end
    select_one_from_multiple_train_types( train_types )
  end

  def error_msg__additional_ary
    str_ary = ::Array.new
    [
      [ "Railway line" , @railway_line_instance.same_as ] ,
      [ "Station" , @station_instance.same_as ] ,
      [ "Terminal station" , @terminal_station_instance.same_as ] ,
      [ "Operation day" , @operation_day_instance.name_en ]
    ].each do | title , info |
      str_ary << title.ljust(24) + " ... " + info
    end
    str_ary
  end

  # 千代田線の列車種別を選択するためのメソッド（乗り入れがない場合）
  # @return [Regexp]
  # @note 上位クラスのメソッドを上書きしている。
  def regexp_to_select_train_type_chiyoda_except_for_for_odakyu_or_jr_joban_line
    if ( is_terminating_at_ayase? and at_kita_ayase? ) or ( is_terminating_at_kita_ayase? and at_ayase? )
      /KitaAyase\Z/
    else
      /Normal\Z/
    end
  end

  # @!group 路線を処理するメソッド

  # 「有楽町線急行」「有楽町線通勤急行」対策
  # @return [nil]
  # @note このクラス特有のメソッド
  def process_railway_line_of_between_wakoshi_and_kotake_mukaihara
    if yurakucho_line? and between_wakoshi_and_kotake_mukaihara? and ( express? or holiday_express? or commuter_express? )
      convert_railway_instance_to_fukutoshin_line
    end
    return nil
  end

  # @!endgroup

end