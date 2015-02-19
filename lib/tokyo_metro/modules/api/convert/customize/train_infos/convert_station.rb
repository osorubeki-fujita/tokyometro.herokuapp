module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStation

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStation::Methods::Info
    end

    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStation::Methods::Info
    end

    ::TokyoMetro::Api::TrainLocation::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStation::Methods::Info
    end
  end

end