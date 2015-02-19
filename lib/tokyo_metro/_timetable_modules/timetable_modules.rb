module TokyoMetro::Modules::Api::TimetableModules

  def self.include_pattern_a
    # include_common_modules

    # ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      # include ::TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::Seed::PatternA
    # end

    #-------- @todo TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::TrainTime::Info::Seed::PatternA の削除
    # ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info.class_eval do
      # include ::TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::TrainTime::Info::Seed::PatternA
    # end

    # ::TokyoMetro::Factories::Seed.module_eval do
      # include ::TokyoMetro::Factories::Seed::PatternA
    # end

    nil
  end

  def self.include_pattern_b
    # include_common_modules

    # [class]
    # ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      # include ::TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::Seed::PatternB
    # end

    # [class]
    # ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info.class_eval do
      # include ::TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::TrainTime::Info::Seed::PatternB
    # end

    # [class]
    # ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      # include ::TokyoMetro::Modules::Api::TimetableModules::TrainTimetable::Info::Seed::PatternB
    # end

    # [module]
    # ::TokyoMetro::Factories::Seed.module_eval do
      # include ::TokyoMetro::Factories::Seed::PatternB
    # end

  end

  class << self

    private

    def include_common_modules

      # ::TokyoMetro::Api::StationTimetable::Info.class_eval do
        # include ::TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::Seed::Common
      # end

      # ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info.class_eval do
        # include ::TokyoMetro::Modules::Api::TimetableModules::StationTimetable::Info::TrainTime::Info::Seed::Common
      # end

    end

  end

end