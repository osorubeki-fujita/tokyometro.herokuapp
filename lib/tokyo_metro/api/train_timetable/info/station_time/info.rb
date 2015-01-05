# 個別の駅の発着時刻情報のクラス
class TokyoMetro::Api::TrainTimetable::Info::StationTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable
  include ::TokyoMetro::ApiModules::ToFactoryClass::GenerateFromHash
  include ::TokyoMetro::ApiModules::InstanceMethods::SeedCompleted
  
  include ::TokyoMetro::ApiModules::Decision::ArrivalStation

  def initialize( arrival_time , arrival_station , departure_time , departure_station )
    @arrival_time = arrival_time
    @arrival_station = arrival_station
    @departure_time = departure_time
    @departure_station = departure_station

    @seed_completed = false
  end

  attr_reader :arrival_time
  attr_reader :arrival_station
  attr_reader :departure_time
  attr_reader :departure_station

  def station
    if @departure_station.present?
      @departure_station
    elsif @arrival_station.present?
      @arrival_station
    else
      raise "Error"
    end
  end

  def time
    h = ::Hash.new
    if @arrival_time.present?
      h[ :arrival ] = [ @arrival_time.hour , @arrival_time.min ]
    end
    if @departure_time.present?
      h[ :departure ] = [ @departure_time.hour , @departure_time.min ]
    end
    h
  end

  def time_to_h
    if @arrival_time.present?
      arrival_time_hour , arrival_time_min = @arrival_time.hour , @arrival_time.min
    else
      arrival_time_hour , arrival_time_min = nil , nil
    end
    if @departure_time.present?
      departure_time_hour , departure_time_min = @departure_time.hour , @departure_time.min
    else
      departure_time_hour , departure_time_min = nil , nil
    end
    {
      arrival_time_hour: arrival_time_hour ,
      arrival_time_min: arrival_time_min ,
      departure_time_hour: departure_time_hour ,
      departure_time_min: departure_time_min
    }
  end

  def only_arrival_time_is_defined?
    @arrival_time.present? and @departure_time.nil?
  end

  def self.generate_from_hash(h)
    super( h , factory_name: :factory_for_generating_station_time_from_hash )
  end

  def station_id_in_db
    ::Station.find_by_same_as( self.station ).id
  end

end