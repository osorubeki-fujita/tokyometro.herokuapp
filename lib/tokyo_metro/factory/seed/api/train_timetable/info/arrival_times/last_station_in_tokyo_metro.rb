class TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::ArrivalTimes::LastStationInTokyoMetro < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  include ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::ArrivalTimes::Common

  private

  def seed_main
    # (1) 千代田線→小田急線のロマンスカーの列車の場合、代々木上原駅の到着時刻の情報に注意
    if romance_car_on_chiyoda_line? and for_odakyu_line?
      # (1.a) 最後の駅情報が「代々木上原駅の到着時刻」ではない場合
      unless info_of_last_station_in_tokyo_metro.arrival_at_yoyogi_uehara?
        # 最後の駅情報はすでにDBに流し込まれているはず
        check_validity_of_romance_car_for_odakyu_line
        # 最後の駅情報がすでにDBに流し込まれていれば、何もしなくてよい
        return nil
      end
    end

    unless romance_car_on_chiyoda_line? and for_odakyu_line?
      check_validity_of_normal_trains
    end

    db_class.find_or_create_by( hash_to_db )

    info_of_last_station_in_tokyo_metro.seed_completed!

    return nil
  end

  def hash_to_db
    _info_of_last_station_in_tokyo_metro = info_of_last_station_in_tokyo_metro
    {
      station_timetable_id: nil ,
      train_type_in_this_station_id: nil ,
      arrival_station_id: arrival_station_id( _info_of_last_station_in_tokyo_metro ) ,
      stop_for_drivers: stop_for_drivers?
    }.merge( base_hash_for_seeding_additional_arrival_times ).merge( _info_of_last_station_in_tokyo_metro.time_to_h )
  end

  def stop_for_drivers?
    # (1) 千代田線→小田急線のロマンスカーの列車の場合
    # (1.b) 最後の駅情報が「代々木上原駅の到着時刻」の場合
    #   ----> true
    romance_car_on_chiyoda_line? and for_odakyu_line? and info_of_last_station_in_tokyo_metro.arrival_at_yoyogi_uehara?
  end

  def check_validity_of_romance_car_for_odakyu_line
    unless info_of_last_station_in_tokyo_metro.seed_completed?
      raise error_message__seed_arrival_times_of_last_station_in_tokyo_metro
    end
  end

  def check_validity_of_normal_trains
    if info_of_last_station_in_tokyo_metro.seed_completed?
      raise error_message__seed_arrival_times_of_last_station_in_tokyo_metro
    end
    unless info_of_last_station_in_tokyo_metro.only_arrival_time_is_defined?
      raise error_message__seed_arrival_times_of_last_station_in_tokyo_metro
    end
  end

  def error_message__seed_arrival_times_of_last_station_in_tokyo_metro
    last_station_name = info_of_last_station_in_tokyo_metro.station.keys.join( "/" )
    "Error: #{ @same_as } \: #{ last_station_name }"
  end

end