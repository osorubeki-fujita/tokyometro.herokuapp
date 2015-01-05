module TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::NambokuLineForMusashiKosugi

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::NambokuLineForMusashiKosugi::Info
    end

    ::TokyoMetro::Api::StationTimetable::Info::Train::Info.class_eval do
      include ::TokyoMetro::ApiModules::Customize::Timetables::ConvertStation::NambokuLineForMusashiKosugi::TrainInfo
    end
  end

end