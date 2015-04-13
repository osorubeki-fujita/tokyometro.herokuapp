# 個別の路線情報を扱うクラス
# @note
#   DB への流し込みは、{TokyoMetro::Static::RailwayLine::Info}#seed （{TokyoMetro::Modules::Common::ToFactory::Seed::Info} で定義）で行う。
#   関連： {TokyoMetro::Factory::Seed::Static::RailwayLine::Info}
class TokyoMetro::Api::RailwayLine::Info < TokyoMetro::Api::MetaClass::Hybrid::Info

  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase
  include ::TokyoMetro::Modules::Common::Info::Decision::SameAs
  include ::TokyoMetro::Modules::Common::Info::Decision::Operator

  include ::TokyoMetro::Modules::Api::Info::Decision::RailwayLine
  include ::TokyoMetro::Modules::Common::Info::RailwayLine
  include ::TokyoMetro::Modules::Common::Info::RailwayLine::BranchLine

  include ::TokyoMetro::Modules::Api::Info::ToStringWithArray

  # @!group Constructor

  # Constructor
  def initialize( id_urn , same_as , title , region , operator , railway_line_code ,
    station_order , travel_time , women_only_car , dc_date )
    @id_urn = id_urn
    @same_as = same_as
    @title = title
    @region = region
    @operator = operator
    @railway_line_code = railway_line_code
    @station_order = station_order
    @travel_time = travel_time
    @women_only_car = women_only_car
    @dc_date = dc_date
  end

  # @!endgroup

  # @!group メタデータ (For developers)

  # 固有識別子 (ucode)
  # @return [String]
  # @note 支線には別IDを割り当てる
  attr_reader :id_urn

  # 固有識別子 <owl:sameAs - URL>
  # @note 命名ルールは「odpt.Railway:TokyoMetro.路線名」
  attr_reader :same_as

  # 路線形状データを Geojson で取得するためのURL <ug:region - odpt:GeoDocument>
  # @return [String]
  # @note ここで ug:region が指し示すURLは、路線形状データを GeoJSON で取得するためのURLとなる。
  # @note GeoJSON 取得には、ug:regionに記載されているURLに加えて、アクセストークンの付与が必要である。
  attr_reader :region

  # @!group 一般の情報

  # 運行会社 <odpt:operator - odpt:Operator>
  # @return [String]
  attr_reader :operator

  # 運行系統名 <dc:title - xsd:string>
  # @return [String]
  # @note 運行系統名 dc:title は、一般的に用いられる路線名・愛称を示す。
  attr_reader :title

  # 路線コード <odpt:lineCode - xsd:string>
  # @return [String]
  attr_reader :railway_line_code

  # 駅の順序 <odpt:stationOrder - Array>
  # @return [StationOrder::List <StationOrder::Info>]
  attr_reader :station_order

  # 駅間の標準所要時間リスト <odpt:travelTime - Array>
  # @return [TravelTime::List <TravelTime::Info>]
  attr_reader :travel_time

  # 女性専用車両情報のリスト <odpt:womenOnlyCar - Array (odpt:WomenOnlyCar)>
  # @return [WomenOnlyCar::List <WomenOnlyCar::Info>]
  attr_reader :women_only_car

  attr_reader :dc_date

  alias :geo_json :region

  # @!group 路線情報の取得

  # ファイル名に使用する路線名
  # @note 丸ノ内線の「M」と「m」の競合を防ぐため
  def railway_line_code_for_filename
    if /\A[a-z]/ === railway_line_code
      "#{railway_line_code.capitalize}_small"
    else
      railway_line_code
    end
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    to_s_with_array( [ "odpt:stationOrder" , "odpt:travelTime" , "odpt:womenOnlyCar" ] , indent )
  end

  alias :to_strf :to_s

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new
    set_data_to_hash( h , "\@id" , @id_urn )
    set_data_to_hash( h , "owl:sameAs" , @same_as )
    set_data_to_hash( h , "dc:title" , @title )
    set_data_to_hash( h , "ug:region" , @region )
    set_data_to_hash( h , "odpt:operator" , @operator )
    set_data_to_hash( h , "odpt:lineCode" , @railway_line_code )

    set_data_to_hash( h , "odpt:stationOrder" , @station_order )
    set_data_to_hash( h , "odpt:travelTime" , @travel_time )
    set_data_to_hash( h , "odpt:womenOnlyCar" , @women_only_car )
    set_data_to_hash( h , "dc:date" , @dc_date )

    h
  end

  # @note {TokyoMetro::Api::RailwayLine::Info::StationOrder::List#seed} を実行
  # @note 使用停止中 - {TokyoMetro::Static::Station::InEachRailwayLine::Info#seed}を参照
  def seed_station_order_infos
    @station_order.seed
  end

  def seed_travel_time_infos
    @travel_time.try( :seed , railway_line_id )
  end

  def seed_women_only_car_infos
    @women_only_car.try( :seed , railway_line_id )
  end

  def railway_line_id
    ::RailwayLine.find_by( same_as: @same_as ).id
  end

  # @!endgroup

  private

  def on_the_railway_line_of?( *variables )
    super( *variables , @same_as )
  end

  alias :is_on_the_railway_line_of? :on_the_railway_line_of?

end