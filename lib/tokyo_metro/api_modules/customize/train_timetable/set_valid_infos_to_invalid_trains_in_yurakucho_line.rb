module TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine

  def self.factory_of_valid_station_times_of_weekdays
    ::TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine::Factory::ValidStationTimesOfWeekdays
  end

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::List.class_eval do
      include ::TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine::List
    end

    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine::Info
    end

    ::TokyoMetro::Api::TrainTimetable::Info::StationTime::List.class_eval do
      include ::TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine::StationTimeList
    end

    ::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info.class_eval do
      include ::TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine::StationTime
    end

    ::TokyoMetro::Factories::Api::GenerateFromSavedFile::TrainTimetable.class_eval do
      include ::TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine::GenerateFromSavedFile
    end
  end

end

# set_valid_infos_to_invalid_trains_in_yurakucho_line/list.rb
# set_valid_infos_to_invalid_trains_in_yurakucho_line/info.rb
# set_valid_infos_to_invalid_trains_in_yurakucho_line/station_time_list.rb
# set_valid_infos_to_invalid_trains_in_yurakucho_line/station_time.rb

# set_valid_infos_to_invalid_trains_in_yurakucho_line/generate_from_saved_file.rb
# set_valid_infos_to_invalid_trains_in_yurakucho_line/factory.rb