# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::Station::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::Station
  include ::TokyoMetro::Factory::Generate::Api::MetaClass::Info::ConvertAndSetArrayData::ModuleForMethod

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]
    title = @hash[ "dc:title" ]
    dc_date = DateTime.parse( @hash[ "dc:date" ] )

    geo_long = @hash[ "geo:long" ]
    geo_lat = @hash[ "geo:lat" ]
    region = @hash[ "ug:region" ]

    operator = @hash[ "odpt:operator" ]
    railway_line = @hash[ "odpt:railway" ]

    facility = @hash[ "odpt:facility" ]

    station_code = @hash[ "odpt:stationCode" ]

    [ id , same_as , title , dc_date , geo_long , geo_lat , region ,
      operator , railway_line , connecting_railway_lines , facility , link_to_passenger_survey , station_code , exit_list ]
  end

  private

  def connecting_railway_lines
    covert_and_set_array_data(
      "odpt:connectingRailway" ,
      ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::List ,
      ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info
    )
  end

  def link_to_passenger_survey
    covert_and_set_array_data(
      "odpt:passengerSurvey" ,
      ::TokyoMetro::Api::Station::Info::LinkToPassengerSurvey::List ,
      ::TokyoMetro::Api::Station::Info::LinkToPassengerSurvey::Info
    )
  end

  def exit_list
    covert_and_set_array_data(
      "odpt:exit" ,
      ::TokyoMetro::Api::Station::Info::Exit::List ,
      ::TokyoMetro::Api::Station::Info::Exit::Info
    )
  end

end