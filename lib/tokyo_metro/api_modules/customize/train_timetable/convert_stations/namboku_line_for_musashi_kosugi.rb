module TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::NambokuLineForMusashiKosugi

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::Customize::Timetables::ConvertStation::NambokuLineForMusashiKosugi::TrainInfo
      prepend ::TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::NambokuLineForMusashiKosugi::Info
    end
  end

end