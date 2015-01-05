# 個別の駅情報 mlit:Station のクラス
class TokyoMetro::Api::MlitStation::Info < TokyoMetro::Api::MlitRailwayLine::Info

  include ::TokyoMetro::ClassNameLibrary::Api::MlitStation

  # Constructor
  def initialize( id_urn , geo_long , geo_lat , region , mlit_station_name , mlit_operator_name , mlit_railway_line_name )
    super( id_urn , geo_long , geo_lat , region , mlit_operator_name , mlit_railway_line_name )
    @mlit_station_name = mlit_station_name
  end

  # @!group 一般の情報

  # 駅名 <mlit:stationName - xsd:string>
  # @return [String]
  attr_reader :mlit_station_name

  alias :station_name :mlit_station_name

  # @!endgroup

  # @!group 駅情報の取得

  def to_h_sub_2(h)
    set_data_to_hash( h , "mlit:stationName" , @mlit_station_name )
    super(h)
  end
  private :to_h_sub_2

  # @!endgroup

end