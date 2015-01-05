module TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternA

  extend ::ActiveSupport::Concern

  def seed( timetable_id_in_db , operation_day_instance , railway_line_instance , station_instance )
    terminal_station_instance = ::Station.find_by_same_as( @terminal_station )
    to_station_id = terminal_station_instance.id

    train_type_id = train_type_id_in_db( railway_line_instance , terminal_station_instance , operation_day_instance , station_instance )

    seed__inspect_terminal_station_and_to_station( terminal_station_instance , to_station_id )

    seed_h = {
      timetable_id: timetable_id_in_db ,
      operation_day_id: operation_day_instance.id ,
      departure_time_hour: @departure_time.hour ,
      departure_time_min: @departure_time.min ,
      to_station_id: to_station_id ,
      train_type_id: train_type_id ,
      is_last: @is_last ,
      is_origin: start_from_this_station? ,
      car_composition: @car_composition ,
      depart_from: depart_from ,
      timetable_starting_station_info_id: timetable_starting_station_info_id_in_db( railway_line_instance ) ,
      timetable_arrival_info_id: timetable_arrival_info_id_in_db( railway_line_instance ) ,
      timetable_connection_info_id: timetable_connection_info_id_in_db( railway_line_instance ) ,
      timetable_train_type_in_other_operator_id: timetable_train_type_in_other_operator_id_in_db
    }

    ::TrainTime.create( seed_h )

    seed_completed!

    return nil
  end

  module ClassMethods

    def train_type_factory_class
      ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternA::TrainTypeFactory
    end

  end

  private

  def seed__inspect_terminal_station_and_to_station( terminal_station_instance , to_station_id )
    if terminal_station_instance.nil?
      raise "Error: The information of \[Station\] \"#{@terminal_station}\" does not exist in the database."
    end
    if to_station_id.nil?
      raise "Error: The variable \"to_station_id\" should be an integer."
    end
  end

end