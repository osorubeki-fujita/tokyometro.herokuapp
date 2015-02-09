module TokyoMetro::ApiModules::Convert::Patches::StationTimetable::MusashiKosugiInNambokuLine

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Patches::StationTimetable::MusashiKosugiInNambokuLine::Info
    end
  end

end