# 各駅の情報を格納する配列
class TokyoMetro::Api::Station::List < TokyoMetro::Api::MetaClass::Hybrid::List

  include ::TokyoMetro::ClassNameLibrary::Api::Station
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List
  include ::TokyoMetro::Modules::Api::List::Selection::RailwayLines

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 2 )
  end

  # @return [::Array]
  def connecting_railway_lines
    list_up( :connecting_railway_lines )
  end

  def basenames
    list_up( :basename )
  end

  def basenames_to_display
    list_up( :basename_to_display )
  end

  # 配列の各要素のインスタンスの情報をDBに流し込むメソッド
  # @return [nil]
  # @note {TokyoMetro::Static::Station::RailwayLines.seed} を呼び出している。
  def seed
    super( ::Operator.all , ::RailwayLine.all , ::StationFacility.all , display_number: true )
  end

  # 配列に含まれる {TokyoMetro::Api::Station::Info} の各インスタンスの乗換路線情報を DB に流し込むメソッド
  # @note 各駅の基本情報をすべて流し込んでから、乗換路線情報のみを流し込む。（乗換駅の情報を流し込む際に ::Station.find_by を利用しており、既知のすべての駅の流し込みが済んでいなければならないため）
  # @example
  #   TokyoMetro::Api::Station::List.factory_for_seeding_connecting_railway_lines
  #     => TokyoMetro::Factory::Seed::Api::Station::List::ConnectingRailwayLine
  def seed_connecting_railway_lines
    seed_sub_infos( :factory_for_seeding_connecting_railway_lines , __method__ )
  end

  # 出入口の情報をDBに流し込むメソッド
  # @return [nil]
  def seed_exits
    seed_sub_infos( :factory_for_seeding_exits , __method__ )
  end

  # 乗降客数の情報をDBに流し込むメソッド
  # @return [nil]
  def seed_link_to_passenger_surveys
    seed_sub_infos( :factory_for_seeding_link_to_passenger_surveys , __method__ )
  end

  # データベースへの流し込みの際に使用する配列（路線・駅のID順に整列している）
  # @return [::TokyoMetro::Api::Station::List]
  def to_seed
    railway_lines = ::RailwayLine.all
    stations_in_each_line = self.group_by { | station |
      railway_line = railway_lines.find_by( same_as: station.railway_line )
      if railway_line.nil?
        raise "Error: data of the railway_line same as \"#{ station.railway_line }\" does not exist."
      end
      railway_line.id
    }

    ary = ::Array.new

    stations_in_each_line.keys.sort.each do | line |
      ary += stations_in_each_line[ line ].sort_by( &:station_code )
    end

    self.class.new( ary )
  end

  private

  def list_up( procedure )
    ary = self.map( &procedure ).flatten.uniq.sort
    ::Array.new( ary )
  end

  def seed_sub_infos( factory_name , method_name )
    __seed__(
      factory_name: factory_name ,
      method_name: method_name ,
      indent: 0 ,
      not_on_the_top_layer: false ,
      display_number: true
    )
  end

end