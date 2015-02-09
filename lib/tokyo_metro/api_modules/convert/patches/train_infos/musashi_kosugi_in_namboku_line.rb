module TokyoMetro::ApiModules::Convert::Patches::TrainInfos::MusashiKosugiInNambokuLine

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Patches::TrainInfos::MusashiKosugiInNambokuLine::Methods::Info
    end

    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Patches::TrainInfos::MusashiKosugiInNambokuLine::Methods::Info
      prepend ::TokyoMetro::ApiModules::Convert::Patches::TrainInfos::MusashiKosugiInNambokuLine::Initializer::Info
    end

    ::TokyoMetro::Api::TrainLocation::Info.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Patches::TrainInfos::MusashiKosugiInNambokuLine::Methods::Info
      prepend ::TokyoMetro::ApiModules::Convert::Patches::TrainInfos::MusashiKosugiInNambokuLine::Initializer::Info
    end
  end

end