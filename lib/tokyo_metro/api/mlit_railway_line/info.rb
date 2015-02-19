# 路線情報 mlit:Railway のクラス
class TokyoMetro::Api::MlitRailwayLine::Info < TokyoMetro::Api::MetaClass::Geo::Info

  include ::TokyoMetro::ClassNameLibrary::Api::MlitRailwayLine

  # インスタンスメソッドの追加
  include ::TokyoMetro::Modules::Api::Info::ToJson
  include ::TokyoMetro::Modules::Api::Info::ToStringGeneral
  include ::TokyoMetro::Modules::Api::Info::ToStringWithArray

  # Constructor
  def initialize( id_urn , geo_long , geo_lat , region , mlit_operator_name , mlit_railway_line_name )
    @id_urn = id_urn

    @geo_long = geo_long
    @geo_lat = geo_lat
    @region = region

    @mlit_operator_name = mlit_operator_name
    @mlit_railway_line_name = mlit_railway_line_name
  end

  # @!group 地理情報 (For developers)

  # 代表点の経度（10進表記）
  # @return [Float]
  attr_reader :geo_long

  # 代表点の緯度（10進表記）
  # @return [Float]
  attr_reader :geo_lat

  # 駅形状データを GeoJSON で取得するURL <ug:region - odpt:GeoDocument>
  # @return [Integer]
  # @note 取得にはアクセストークンの付与が必要
  attr_reader :region

  # @!group 一般の情報

  # 運営会社名 <mlit:operatorName - xsd:string>
  # @return [String]
  attr_reader :mlit_operator_name

  # 路線名 <mlit:railwayName - xsd:string>
  # @return [String]
  attr_reader :mlit_railway_line_name

  alias :operator_name :mlit_operator_name
  alias :railway_line_name :mlit_railway_line_name

  # @!group 駅情報の取得

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    to_s_with_array( [] , indent )
  end

  alias :to_strf :to_s

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new
    to_h_sub_1(h)
    to_h_sub_2(h)
    h
  end

  # @!endgroup

  def to_h_sub_1(h)
    set_data_to_hash( h , "\@id" , @id_urn )
    set_data_to_hash( h , "ug:region" , @region )
  end
  private :to_h_sub_1

  def to_h_sub_2(h)
    set_data_to_hash( h , "mlit:operatorName" , @mlit_operator_name )
    set_data_to_hash( h , "mlit:railwayName" , @mlit_railway_line_name )

    set_data_to_hash( h , "geo:long" , @geo_long )
    set_data_to_hash( h , "geo:lat" , @geo_lat )
  end
  private :to_h_sub_2

end