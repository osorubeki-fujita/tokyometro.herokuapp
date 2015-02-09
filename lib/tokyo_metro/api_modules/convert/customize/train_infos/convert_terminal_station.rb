module TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ConvertTerminalStation

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ConvertTerminalStation::Methods::Info
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ConvertTerminalStation::Initializer::Info
    end

    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ConvertTerminalStation::Methods::Info
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ConvertTerminalStation::Initializer::Info
    end

    ::TokyoMetro::Api::TrainLocation::Info.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ConvertTerminalStation::Methods::Info
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ConvertTerminalStation::Initializer::Info
    end
  end

end