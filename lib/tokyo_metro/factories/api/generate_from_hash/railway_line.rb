# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::RailwayLine < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine
  include ::TokyoMetro::ApiModules::ToFactoryClass::ConvertAndSetArrayData

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]
    title = @hash[ "dc:title" ]
    region = @hash[ "ug:region" ]
    operator = @hash[ "odpt:operator" ]
    railway_line_code = @hash[ "odpt:lineCode" ]
    dc_date = @hash[ "dc:date" ]

    [ id , same_as , title , region , operator , railway_line_code ,
      station_order , travel_time , women_only_car , dc_date ]
  end

  private

  def station_order
    covert_and_set_array_data( "odpt:stationOrder" ,
      ::TokyoMetro::Api::RailwayLine::Info::StationOrder::List , ::TokyoMetro::Api::RailwayLine::Info::StationOrder::Info ,
      generate_info_instance: true )
  end

  def travel_time
    covert_and_set_array_data( "odpt:travelTime" ,
      ::TokyoMetro::Api::RailwayLine::Info::TravelTime::List , ::TokyoMetro::Api::RailwayLine::Info::TravelTime::Info ,
      generate_info_instance: true )
  end

  def women_only_car
    covert_and_set_array_data( "odpt:womenOnlyCar" ,
      ::TokyoMetro::Api::RailwayLine::Info::WomenOnlyCar::List , ::TokyoMetro::Api::RailwayLine::Info::WomenOnlyCar::Info ,
      generate_info_instance: true , to_flatten: true )
  end

end