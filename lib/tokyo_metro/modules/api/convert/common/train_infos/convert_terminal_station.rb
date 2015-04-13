module TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertTerminalStation

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertTerminalStation::Info
    end

    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertTerminalStation::Info
    end

    ::TokyoMetro::Api::TrainLocation::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertTerminalStation::Info
    end
  end

end