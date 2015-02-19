# 個別の駅の発着時刻情報のクラス
class TokyoMetro::Api::TrainTimetable::Info::StationTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable
  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase

  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Api::Info::SeedCompleted

  include ::TokyoMetro::Modules::Api::Info::Decision::ArrivalStation

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
    h = ::Hash.new
    if @arrival_station.present?
      h[ :arrival ] = @arrival_station
    elsif @departure_station.present?
      h[ :departure ] = @departure_station
    else
      raise "Error"
    end
    h
  end

  def is_at?( station_same_as )
    station.values.include?( station_same_as )
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

  def self.factory_for_this_class
    factory_for_generating_station_time_from_hash
  end

  def station_ids
    h = ::Hash.new
    self.station.each do | k , v |
      h[k] = ::Station.find_by_same_as( v ).id
    end
    h
  end

end

__END__



  def seed_each_train_relation_info( relation )
    another_train_name = self.send( relation )
    if another_train_name.present?
      this_train_in_db = ::TrainTimetable.find_by_same_as( @same_as )
      another_train_in_db = ::TrainTimetable.find_by_same_as( another_train_name )
      unless another_train_in_db.present?
        raise "Error: \"#{ another_train_name }\" does not exist in db."
      end
      this_train_in_db.update( { "#{type}_id".intern => another_train_in_db.id } )
    end
  end