module TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine

  INVALID_TRAINS = ::YAML.load_file( "#{::TokyoMetro::dictionary_dir}/additional_infos/patches/train_timetable/yurakucho_and_fukutoshin_line/invalid_trains_on_yurakucho_line.yaml" )

  def self.factory_of_valid_station_times_of_weekdays
    ::TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine::Factory::ValidStationTimesOfWeekdays
  end

  def self.invalid_trains
    INVALID_TRAINS
  end

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::List.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine::List
    end

    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine::Info
    end

    ::TokyoMetro::Api::TrainTimetable::Info::StationTime::List.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine::Info::StationTime::List
    end

    ::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine::Info::StationTime::Info
    end

    ::TokyoMetro::Factory::Generate::Api::TrainTimetable::List.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine::Generate::List
    end
  end

end