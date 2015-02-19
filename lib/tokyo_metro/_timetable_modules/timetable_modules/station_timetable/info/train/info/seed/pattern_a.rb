module TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::TrainTime::Info::Seed::PatternA

  extend ::ActiveSupport::Concern

  def seed( station_timetable_id , operation_day_in_db , railway_line_in_db , station_in_db )
    terminal_station_in_db = ::Station.find_by_same_as( @terminal_station )
    to_station_id = terminal_station_in_db.id

    train_type_id = train_type_id( railway_line_in_db , terminal_station_in_db , operation_day_in_db , station_in_db )

    seed__inspect_terminal_station_and_to_station( terminal_station_in_db , to_station_id )

    seed_h = {
      station_timetable_id: station_timetable_id ,
      operation_day_id: operation_day_in_db.id ,
      departure_time_hour: @departure_time.hour ,
      departure_time_min: @departure_time.min ,
      to_station_id: to_station_id ,
      train_type_id: train_type_id ,
      is_last: @is_last ,
      is_origin: start_from_this_station? ,
      car_composition: @car_composition ,
      platform_number: platform_number ,
      station_timetable_starting_station_info_id: station_timetable_starting_station_info_id( railway_line_in_db ) ,
      train_timetable_arrival_info_id: train_timetable_arrival_info_id( railway_line_in_db ) ,
      train_timetable_connection_info_id: train_timetable_connection_info_id( railway_line_in_db ) ,
      train_timetable_train_type_in_other_operator_id: train_timetable_train_type_in_other_operator_id
    }

    ::TrainTime.create( seed_h )

    seed_completed!

    return nil
  end

  module ClassMethods

    def train_type_factory_class
      ::TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::TrainTime::Info::Seed::PatternA::TrainTypeFactory
    end

  end

  private

  def seed__inspect_terminal_station_and_to_station( terminal_station_in_db , to_station_id )
    if terminal_station_in_db.nil?
      raise "Error: The information of \[Station\] \"#{@terminal_station}\" does not exist in the database."
    end
    if to_station_id.nil?
      raise "Error: The variable \"to_station_id\" should be an integer."
    end
  end

end











class TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::TrainTime::Info::Seed::PatternA::TrainTypeFactory < TokyoMetro::Factories::Seed::Api::StationTimetable::Info::TrainTime::Info::TrainType

  @patterns = ::Array.new

  def self.train_type_pattern_class
    ::TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::TrainTime::Info::Seed::PatternA::TrainTypeFactory::Pattern
  end

  private

  def romance_car
    super
  end

end




class TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::TrainTime::Info::Seed::PatternA::TrainTypeFactory::Pattern < ::TokyoMetro::Factories::Seed::Api::StationTimetable::Info::TrainTime::Info::TrainType::Pattern
end