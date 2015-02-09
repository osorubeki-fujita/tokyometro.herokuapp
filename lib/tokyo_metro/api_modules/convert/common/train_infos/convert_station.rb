module TokyoMetro::ApiModules::Convert::Common::TrainInfos::ConvertStation

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Common::TrainInfos::ConvertStation::Info
    end

    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Common::TrainInfos::ConvertStation::Info
    end
  end

end