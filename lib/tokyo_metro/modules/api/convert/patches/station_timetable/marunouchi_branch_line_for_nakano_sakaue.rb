module TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::MarunouchiBranchLineForNakanoSakaue

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::MarunouchiBranchLineForNakanoSakaue::Info
    end

    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::MarunouchiBranchLineForNakanoSakaue::Info::TrainTime::Info
    end
  end

end