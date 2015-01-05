module TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::Fundamental

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::Customize::Timetables::ConvertStation::Fundamental::TrainInfo
      include ::TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::Fundamental::Info
    end
  end

end