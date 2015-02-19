# 個別の駅情報を扱うクラス
class TokyoMetro::Api::Station::Info < TokyoMetro::Api::MetaClass::Hybrid::Info

  # インスタンスメソッドの追加
  include ::TokyoMetro::Modules::Api::Info::ToJson
  include ::TokyoMetro::Modules::Api::Info::ToStringGeneral
  include ::TokyoMetro::Modules::Api::Info::ToStringWithArray

  include ::TokyoMetro::ClassNameLibrary::Api::Station
  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase
  include ::TokyoMetro::Modules::Api::Info::Decision::RailwayLine
  include ::TokyoMetro::Modules::Api::Info::Decision::CurrentStation

  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  # Constructor
  def initialize( id_urn , same_as , title , dc_date , geo_long , geo_lat , region ,
      operator , railway_line , connecting_railway_lines , facility , passenger_survey , station_code , exit_list )
    @id_urn = id_urn
    @same_as = same_as
    @title , @dc_date = title , dc_date

    @geo_long = geo_long
    @geo_lat = geo_lat
    @region = region

    @operator = operator
    @railway_line = railway_line
    @connecting_railway_lines = connecting_railway_lines
    @facility = facility
    @passenger_survey = passenger_survey
    @station_code = station_code
    @exit_list = exit_list
  end

  # @!group メタデータ (For developers)
  attr_reader :id_urn

  # 固有識別子 - URL
  # @return [String]
  # @note API での命名ルールは「odpt.Station:TokyoMetro.路線名.駅名」
  attr_reader :same_as

  # データ生成時刻 - xsd:dateTime（ISO8601 日付時刻形式をもとに生成した DateTime のインスタンス）
  # @return [DateTime]
  # @example
  #  2013–01–13T15:10:00+09:00
  attr_reader :dc_date

  # @!group 地理情報 (For developers)

  # 代表点の経度（10進表記）
  # @return [Float]
  attr_reader :geo_long

  # 代表点の緯度（10進表記）
  # @return [Float]
  attr_reader :geo_lat

  # 駅代表点のデータを GeoJSON で取得するためのURL <ug:region - odpt:GeoDocument>
  # @return [String]
  # @note ここでug:regionが指し示すURLは、路線形状データを GeoJSON で取得するためのURLとなる。
  # @note GeoJSON 取得には、ug:regionに記載されているURLに加えて、アクセストークンの付与が必要である。
  # @note 取得される GeoJSON は、駅構内に入線する路線の中央点を取ったPOINTとなる
  attr_reader :region

  # @!group 一般の情報

  # 駅名 - dc:title
  # @return [String]
  attr_reader :title

  # 管理会社 - odpt:operator
  # @return [String]
  attr_reader :operator

  # 鉄道路線ID - odpt:Railway
  # @return [String]
  attr_reader :railway_line

  # 乗り換え可能路線の一覧
  # @return [::Array <odpt:Railway>]
  attr_reader :connecting_railway_lines

  # 駅施設を表すオブジェクトのURI - odpt:facility
  # @return [::Array <odpt:StationFacility>]
  attr_reader :facility

  # 駅乗降人員数を表すオブジェクトへのリンク - odpt:passengerSurvey
  # @return [Info::LinkToPassengerSurvey::List <odpt:PassengerSurvey>]
  attr_reader :passenger_survey

  # 駅コード - odpt:stationCode
  # @return [String]
  attr_reader :station_code

  # 駅出入口を表すオブジェクトへのリンク - odpt:exit
  # @return [Info::Exit::List <ug:Poi>]
  attr_reader :exit_list

  alias :station :title

  alias :longitude :geo_long
  alias :latitude :geo_lat
  alias :geo_json :region

  # @!group 駅情報の取得

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    to_s_with_array( [ "odpt:connectingRailway" , "odpt:passengerSurvey" , "odpt:exit" ] , indent )
  end

  alias :to_strf :to_s

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new

    set_data_to_hash( h , "\@id" , @id_urn )
    set_data_to_hash( h , "owl:sameAs" , @same_as )
    set_data_to_hash( h , "dc:date" , @dc_date.to_s )
    set_data_to_hash( h , "ug:region" , @region )

    set_data_to_hash( h , "odpt:operator" , @operator )
    set_data_to_hash( h , "odpt:railway" , @railway_line )

    set_data_to_hash( h , "odpt:stationCode" , @station_code )
    set_data_to_hash( h , "dc:title" , @title )

    set_data_to_hash( h , "geo:long" , @geo_long )
    set_data_to_hash( h , "geo:lat" , @geo_lat )

    set_data_to_hash( h , "odpt:connectingRailway" , @connecting_railway_lines )
    set_data_to_hash( h , "odpt:facility" , @facility )
    set_data_to_hash( h , "odpt:passengerSurvey" , @passenger_survey )
    set_data_to_hash( h , "odpt:exit" , @exit_list )

    h
  end

  def basename
    @same_as.gsub( /\Aodpt\.Station\:TokyoMetro\.[[:alpha:]]+\.([[:alpha:]]+)\Z/ ) { $1 }
  end

  def basename_to_display
    self.basename.gsub( /(?<=[a-z])([A-Z])/ ) { "-#{$1.downcase}" }
  end

  def title_shift_jis
    case @title
    when "麴町"
      "麹町"
    else
      @title
    end
  end

  alias :name_ja :title_shift_jis

  def seed_connecting_railway_lines( indent )
    @connecting_railway_lines.try( :seed , station_id , indent )
  end

  def seed_exits( indent )
    @exit_list.try( :seed , station_id , indent )
  end

  def seed_link_to_passenger_surveys( indent )
    @passenger_survey.try( :seed , station_id , indent )
  end

  private

  def station_id
    instance_in_db.id
  end

  def instance_in_db
    ::Station.find_by_same_as( @same_as )
  end

  def station_same_as__is_in?( *variables )
    super( *variables , compared: @same_as )
  end

  # @!endgroup

end