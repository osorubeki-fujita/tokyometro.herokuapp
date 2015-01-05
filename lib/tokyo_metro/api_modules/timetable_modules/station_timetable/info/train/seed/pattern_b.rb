module TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternB

  extend ::ActiveSupport::Concern

  def seed(h)
    station_timetable_instance = h[ :station_timetable_instance_in_db ]
    train_timetable_instance = h[ :train_timetable_in_db ]
    station_time_instance = h[ :station_time ]
    operation_day_instance = h[ :operation_day ]

    timetable_starting_station_info_id = timetable_starting_station_info_id_in_db( station_timetable_instance.railway_line )
    puts "Train is same as: " + train_timetable_instance.same_as
    puts "Terminal station: " + train_timetable_instance.terminal_station.same_as
    puts "Train number: " + train_timetable_instance.train_number

    train_type_in_this_station_id = train_type_id_in_db(
      station_timetable_instance.railway_line ,
      train_timetable_instance.terminal_station ,
      operation_day_instance ,
      station_timetable_instance.station
    )

    h = {
      timetable_id: station_timetable_instance.id ,
      train_timetable_id: train_timetable_instance.id ,
      is_last: @is_last ,
      is_origin: start_from_this_station? ,
      depart_from: depart_from ,
      timetable_starting_station_info_id: timetable_starting_station_info_id ,
      train_type_in_this_station_id: train_type_in_this_station_id ,
      arrival_info_of_last_station_in_tokyo_metro: false ,
      last_station_in_tokyo_metro_id: nil ,
      stop_for_drivers: false
    }
    ::StationTrainTime.create( h.merge( station_time_instance.time_to_h ) )

    self.class.train_timetable_update_processor_class.process( self , station_timetable_instance , train_timetable_instance )
  end

  module ClassMethods

    def train_type_factory_class
      ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternB::TrainTypeFactoryInEachStation
    end

    def train_timetable_update_processor_class
      ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternB::TrainTimetableUpdateProcessor
    end

  end

end