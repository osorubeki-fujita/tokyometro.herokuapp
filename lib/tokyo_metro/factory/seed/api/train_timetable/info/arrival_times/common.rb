module TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::ArrivalTimes::Common

  include ::TokyoMetro::Factory::Seed::Reference::Station

  private

  def method_name_for_db_instance_class
    :db_instance_class_of_station_train_time
  end

  def romance_car_on_chiyoda_line?
    @info.romance_car_on_chiyoda_line?
  end

  def for_odakyu_line?
    @info.terminating_on_odakyu_line? or @info.terminating_on_hakone_tozan_line?
  end

  def for_chiyoda_line?
    @info.terminating_on_chiyoda_line?
  end

  def station_times
    @info.valid_list
  end

  def info_of_last_station_in_tokyo_metro
    station_times.last
  end

  def arrival_station_id( station_time )
    station_id( search_by: station_time.station[ :arrival ] )
  end

  def train_timetable_id
    @info.instance_in_db.id
  end

  def base_hash_for_seeding_additional_arrival_times
    {
      train_timetable_id: train_timetable_id ,
      is_last: nil ,
      is_origin: nil ,
      platform_number: nil ,
      station_timetable_starting_station_info_id: nil ,
    }
  end

end