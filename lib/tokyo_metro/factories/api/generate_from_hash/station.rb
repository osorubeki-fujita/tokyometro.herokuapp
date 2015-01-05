# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::Station < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::Fundamental

  include ::TokyoMetro::ApiModules::ToFactoryClass::ConvertAndSetArrayData
  include ::TokyoMetro::ClassNameLibrary::Api::Station

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]
    title = @hash[ "dc:title" ]
    date = DateTime.parse( @hash[ "dc:date" ] )

    geo_long = @hash[ "geo:long" ]
    geo_lat = @hash[ "geo:lat" ]
    region = @hash[ "ug:region" ]

    operator = @hash[ "odpt:operator" ]
    railway_line = @hash[ "odpt:railway" ]

    facility = @hash[ "odpt:facility" ]

    station_code = @hash[ "odpt:stationCode" ]

    [ id , same_as , title , date , geo_long , geo_lat , region ,
      operator , railway_line , connecting_railway_lines , facility , passenger_survey , station_code , exit_list ]
  end

  private

  def connecting_railway_lines
    covert_and_set_array_data( "odpt:connectingRailway" , ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::List )
  end

  def passenger_survey
    covert_and_set_array_data( "odpt:passengerSurvey" , ::TokyoMetro::Api::Station::Info::LinkToPassengerSurvey::List )
  end

  def exit_list
    covert_and_set_array_data( "odpt:exit" , ::TokyoMetro::Api::Station::Info::Exit::List )
  end

end