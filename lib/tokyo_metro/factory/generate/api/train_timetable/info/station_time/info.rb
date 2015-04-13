# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::TrainTimetable::Info::StationTime::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  def variables
    arrival_time = set_time_variable( "odpt:arrivalTime" )
    arrival_station = @hash[ "odpt:arrivalStation" ]
    departure_time = set_time_variable( "odpt:departureTime" )
    departure_station = @hash[ "odpt:departureStation" ]

    [ arrival_time , arrival_station , departure_time , departure_station ]
  end

  def self.instance_class
    station_time_class
  end

  private

  def set_time_variable( k )
    if @hash[ k ].present?
      ::DateTime.convert_str( @hash[ k ] )
    else
      nil
    end
  end

end