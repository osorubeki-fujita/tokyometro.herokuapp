module TokyoMetro::ApiModules::TimetableModules

  WEEKDAY = "Weekday"
  SATURDAY_AND_HOLIDAY = "Saturday and holiday"
  
  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  def self.include_pattern_a

    ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Seed::Common
      include ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Seed::PatternA
    end

    ::TokyoMetro::Api::StationTimetable::Info::Train::Info.class_eval do
      include ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::Common
      include ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternA
    end

    ::TokyoMetro::Seed.module_eval do
      include ::TokyoMetro::Seed::PatternA
    end

  end

  def self.include_pattern_b

    # [class]
    ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Seed::Common
      include ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Seed::PatternB
    end

    # [class]
    ::TokyoMetro::Api::StationTimetable::Info::Train::Info.class_eval do
      include ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::Common
      include ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternB
    end

    # [class]
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::TimetableModules::TrainTimetable::Info::Seed::PatternB
    end

    # [module]
    ::TokyoMetro::ApiModules::TimetableModules.module_eval do

      def self.seed_station_train_time( *method_name_for_selecting_railway_line )
        ::TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB.process( *method_name_for_selecting_railway_line )
      end

    end

    # [module]
    ::TokyoMetro::Seed.module_eval do
      include ::TokyoMetro::Seed::PatternB
    end

  end

end