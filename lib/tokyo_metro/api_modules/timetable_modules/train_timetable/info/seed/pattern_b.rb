module TokyoMetro::ApiModules::TimetableModules::TrainTimetable::Info::Seed::PatternB

  extend ::ActiveSupport::Concern

  def seed( operators , railway_lines , stations , railway_directions , train_owners , whole: nil , now_at: nil , indent: 0 )
    ::TokyoMetro::Seed::Inspection.title_with_method( self.class , __method__ , indent: indent , other: @same_as , whole: whole , now_at: now_at )
    time_begin = Time.now

    railway_line_instance = railway_lines.find_by_same_as( @railway_line )
    starting_station_instance = ::Station.find_by_same_as( @starting_station )
    terminal_station_instance = ::Station.find_by_same_as( @terminal_station )

    if starting_station_instance.nil?
      raise "Error: #{ @starting_station }"
    end
    if terminal_station_instance.nil?
      raise "Error: #{ @terminal_station }"
    end

    operation_day_id = operation_day_id_in_db
    operation_day_instance = ::OperationDay.find_by_id( operation_day_id )

    train_type_id = train_type_id_in_db( railway_line_instance , starting_station_instance , terminal_station_instance , operation_day_instance )

    h = {
      id_urn: @id_urn ,
      same_as: @same_as ,
      dc_date: @dc_date ,
      train_number: @train_number ,
      railway_line_id: railway_line_instance.id ,
      operator_id: operators.find_by_same_as( @operator ).id ,
      train_type_id: train_type_id ,
      railway_direction_id: railway_directions.find_by( in_api_same_as: @railway_direction , railway_line_id: railway_line_instance.id ).id ,
      train_owner_id: train_owners.find_by_same_as( @train_owner ).id ,
      operation_day_id: operation_day_id ,
      starting_station_id: starting_station_instance.id ,
      terminal_station_id: terminal_station_instance.id
    }

    # [Update で追加] car_composition
    # [Update で追加] timetable_arrival_info_id
    # [Update で追加] timetable_connection_info_id
    # [Update で追加] timetable_train_type_in_other_operator_id

    ::TrainTimetable.create(h)

    # seed_station_times
    ::TokyoMetro::Seed::Inspection.time( time_begin , indent: indent )
  end

  # @!group DBへの流し込みに関するメソッド

  def seed_arrival_times_of_romance_car
    unless romance_car_on_chiyoda_line?
      return nil
    end

    station_times = valid_list
    train_timetable_id = instance_in_db.id
    train_type_in_this_station_id = ::TrainType.find_by_same_as( "custom.TrainType:TokyoMetro.Chiyoda.RomanceCar.Normal" ).id
    railway_line_instance = ::RailwayLine.find_by_same_as( @railway_line )

    # 千代田線→小田急線の列車の場合
    # 末尾に代々木上原の到着時刻が定義されている場合は無視する。
    # @note 運転停車の到着時刻の処理は #seed_arrival_times_of_last_station_in_tokyo_metro で行う。
    #   @note TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB#seed__arrival_times_of_last_station_in_tokyo_metro_for_each_train を経由する。
    if is_terminating_on_odakyu_line? or is_terminating_on_hakone_tozan_line?
      if valid_list.last.arrival_station == "odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara"
        station_times = station_times[0..-2]
      end
      # 代々木上原以外の各駅の出発時刻は、すでにDBへ流し込まれているはずである。
      station_times.each do | station_time |
        unless station_time.seed_completed?
          raise "Error: #{@same_as} ... Departure time of \"#{station_time.station}\" is not seed yet."
        end
      end
      # したがって、このメソッドでは何もすることはない。
      return nil
    # 小田急線→千代田線の列車の場合
    # 終着駅の処理は、ロマンスカー以外の列車も含め #seed_arrival_times_of_last_station_in_tokyo_metro で行う。
    #   @note TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB#seed__arrival_times_of_last_station_in_tokyo_metro_for_each_train を経由する。
    elsif is_terminating_on_chiyoda_line?
      station_times = station_times[0..-2]
    else
      raise "Error"
    end

    station_times.each do | station_time |
      h_to_select_timetable = {
        railway_line_id: railway_line_instance.id ,
        railway_direction_id: ::RailwayDirection.find_by( in_api_same_as: @railway_direction , railway_line_id: railway_line_instance.id ).id ,
        station_id: ::Station.find_by_same_as( station_time.station ).id
      }

      h = {
        timetable_id: ::Timetable.find_by( h_to_select_timetable ).id ,
        train_type_in_this_station_id: train_type_in_this_station_id ,
        arrival_info_of_last_station_in_tokyo_metro: false ,
        last_station_in_tokyo_metro_id: nil ,
        stop_for_drivers: false
      }
      h = h.merge( base_hash_for_seeding_additional_arrival_times( train_timetable_id ) )
      h = h.merge( station_time.time_to_h )
      ::StationTrainTime.create(h)

      station_time.seed_completed!
    end

    return nil
  end

  def seed_arrival_times_of_last_station_in_tokyo_metro
    info_of_last_station_in_tokyo_metro = valid_list.last

    # (1) 千代田線→小田急線のロマンスカーの列車の場合、代々木上原駅の到着時刻の情報に注意
    if romance_car_on_chiyoda_line? and ( is_terminating_on_odakyu_line? or is_terminating_on_hakone_tozan_line? )
      # (1.a) 最後の駅情報が「代々木上原駅の到着時刻」の場合
      if info_of_last_station_in_tokyo_metro.arrival_at_yoyogi_uehara?
        # 代々木上原の到着時刻の処理を行う必要がある。
        # 運転停車の属性を設定する。
        stop_for_drivers = true
      # (1.b) 最後の駅情報が「代々木上原駅の到着時刻」ではない場合
      else
        # 最後の駅情報はすでにDBに流し込まれているはず
        unless info_of_last_station_in_tokyo_metro.seed_completed?
          raise "Error"
        end
        # 最後の駅情報がすでにDBに流し込まれていれば、何もしなくてよい
        return nil
      end

    else
      if info_of_last_station_in_tokyo_metro.seed_completed?
        raise error_message__seed_arrival_times_of_last_station_in_tokyo_metro( info_of_last_station_in_tokyo_metro.station )
      end
      unless info_of_last_station_in_tokyo_metro.only_arrival_time_is_defined?
        raise error_message__seed_arrival_times_of_last_station_in_tokyo_metro( info_of_last_station_in_tokyo_metro.station )
      end
      stop_for_drivers = false
    end

    train_timetable_id = instance_in_db.id

    h = {
      timetable_id: nil ,
      train_type_in_this_station_id: nil ,
      arrival_info_of_last_station_in_tokyo_metro: true ,
      last_station_in_tokyo_metro_id: info_of_last_station_in_tokyo_metro.station_id_in_db ,
      stop_for_drivers: stop_for_drivers
    }
    h = h.merge( base_hash_for_seeding_additional_arrival_times( train_timetable_id ) )
    h = h.merge( info_of_last_station_in_tokyo_metro.time_to_h )
    ::StationTrainTime.create(h)

    info_of_last_station_in_tokyo_metro.seed_completed!
    return nil
  end

  module ClassMethods

    def train_type_factory_class
      ::TokyoMetro::ApiModules::TimetableModules::TrainTimetable::Info::Seed::PatternB::TrainTypeFactoryOfEachTrain
    end

  end

  private

  def train_type_id_in_db( railway_line_instance , starting_station_instance , terminal_station_instance , operation_day_instance )
    self.class.train_type_factory_class.id_in_db( @train_type , railway_line_instance , starting_station_instance , terminal_station_instance , operation_day_instance )
  end

  def operation_day_id_in_db
    if operated_on_weekdays?
      name_en = ::TokyoMetro::ApiModules::TimetableModules.weekday
    elsif operated_on_saturdays_and_holidays?
      name_en = ::TokyoMetro::ApiModules::TimetableModules.saturday_and_holiday
    else
      raise "Error: \"#{ @same_as }\" is not valid."
    end
    ::TokyoMetro::Seed::OperationDayProcesser.find_or_create_by_and_get_ids_of( name_en ).first
  end

  def error_message__seed_arrival_times_of_last_station_in_tokyo_metro( last_station_name )
    "Error: #{ @same_as } \: #{ last_station_name }"
  end

  def base_hash_for_seeding_additional_arrival_times( train_timetable_id )
    {
      train_timetable_id: train_timetable_id ,
      is_last: nil ,
      is_origin: nil ,
      depart_from: nil ,
      timetable_starting_station_info_id: nil ,
    }
  end

end