module TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::MarunouchiBranchLineForNakanoSakaue

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::MarunouchiBranchLineForNakanoSakaue::Info
    end

    ::TokyoMetro::Api::StationTimetable::Info::Train::Info.class_eval do
      include ::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::MarunouchiBranchLineForNakanoSakaue::Train
    end
  end

end