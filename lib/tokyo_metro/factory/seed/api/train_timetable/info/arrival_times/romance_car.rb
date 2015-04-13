class TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::ArrivalTimes::RomanceCar < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  include ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::ArrivalTimes::Common

  include ::TokyoMetro::Factory::Seed::Reference::RailwayLine
  include ::TokyoMetro::Factory::Seed::Reference::RailwayDirection
  include ::TokyoMetro::Factory::Seed::Reference::Dictionary::TrainType

  private

  def seed_main
    unless romance_car_on_chiyoda_line?
      return nil
    end

    _station_times_to_seed = station_times_to_seed
    if _station_times_to_seed.blank?
      return nil
    end

    _hash_to_select_station_timetable_base = hash_to_select_station_timetable_base

    _station_times_to_seed.each do | station_time |
      db_class.find_or_create_by( hash_to_db( station_time , _hash_to_select_station_timetable_base ) )
      station_time.seed_completed!
    end

    return nil
  end

  def hash_to_db( station_time , _hash_to_select_station_timetable_base )
    _arrival_station_id = arrival_station_id( station_time )

    {
      train_type_in_this_station_id: train_type_in_this_station_id ,
      station_timetable_id: station_timetable_id( _arrival_station_id , _hash_to_select_station_timetable_base ) ,
      arrival_station_id: _arrival_station_id ,
      stop_for_drivers: false
    }.merge( station_time.time_to_h ).merge( base_hash_for_seeding_additional_arrival_times )
  end

  def station_timetable_id( _arrival_station_id , _hash_to_select_station_timetable_base )
    _station_timetable_ids = station_timetable_ids( _arrival_station_id , _hash_to_select_station_timetable_base ).uniq.sort
    unless _station_timetable_ids.length == 1
      raise "Error: #{ _station_timetable_ids.to_s }"
    end
    _station_timetable_ids.first
  end

  def station_timetable_ids( _arrival_station_id , _hash_to_select_station_timetable_base )
    ::StationTimetableFundamentalInfo.where( hash_to_select_station_timetable( _arrival_station_id , _hash_to_select_station_timetable_base ) ).pluck( :station_timetable_id )
  end

  def hash_to_select_station_timetable( _arrival_station_id , _hash_to_select_station_timetable_base )
    {
      station_id: _arrival_station_id
    }.merge( _hash_to_select_station_timetable_base )
  end

  def hash_to_select_station_timetable_base
    _railway_line_id = railway_line_id
    {
      railway_line_id: _railway_line_id ,
      railway_direction_id: railway_direction_id( _railway_line_id )
    }
  end

  def station_times_to_seed
    _station_times = station_times
    # 千代田線→小田急線の列車の場合
    # DB へ流し込むデータは存在しない（理由は #check_validty_of_the_train_for_odakyu_line に記載）
    if for_odakyu_line?
      check_validty_of_the_train_for_odakyu_line( _station_times )
      return nil
    # 小田急線→千代田線の列車の場合
    # 終着駅の処理は、ロマンスカー以外の列車も含め #seed_arrival_times_of_last_station_in_tokyo_metro で行う。
    elsif for_chiyoda_line?
      station_times[0..-2]
    else
      raise "Error"
    end
  end

  def check_validty_of_the_train_for_odakyu_line( _station_times )
    # 末尾に代々木上原の到着時刻が定義されている場合は無視する。
    # @note 運転停車の到着時刻の処理は TokyoMetro::Api::TrainTimetable::Info#seed_arrival_times_of_last_station_in_tokyo_metro で行う。
    if info_of_last_station_in_tokyo_metro.arrival_station == "odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara"
      _station_times = _station_times[0..-2]
    end
    # 代々木上原以外の各駅の出発時刻は、すでにDBへ流し込まれているはずである。
    _station_times.each do | station_time |
      unless station_time.seed_completed?
        raise "Error: #{@same_as} ... Departure time of \"#{station_time.station}\" is not seed yet."
      end
    end
    # したがって、このメソッドでは何もすることはない。
  end

  def train_type_in_this_station_id
    romance_car.id
  end

end