module TokyoMetro::ApiModules::Convert::Common::StationTimetable::ConvertTerminalStations

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Common::StationTimetable::ConvertTerminalStations::Info
    end
  end

end