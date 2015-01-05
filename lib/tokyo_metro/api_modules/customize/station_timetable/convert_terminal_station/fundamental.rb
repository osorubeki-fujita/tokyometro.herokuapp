module TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::Fundamental

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::Fundamental::Info
    end

    ::TokyoMetro::Api::StationTimetable::Info::Train::Info.class_eval do
      include ::TokyoMetro::ApiModules::Customize::Timetables::ConvertStation::Fundamental::TrainInfo
    end
  end

end