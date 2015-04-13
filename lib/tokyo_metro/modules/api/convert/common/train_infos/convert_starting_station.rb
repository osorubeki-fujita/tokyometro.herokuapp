# @note {TokyoMetro::Modules::Api::Convert::Common::TrainTimetable#.set_modules} により {::TokyoMetro::Api::TrainTimetable::Info} へ include される。
module TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertStartingStation

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertStartingStation::Info
    end

    ::TokyoMetro::Api::TrainLocation::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertStartingStation::Info
    end
  end

end