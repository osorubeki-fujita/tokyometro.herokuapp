module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStartingStation

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStartingStation::Methods::Info
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStartingStation::Initializer::Info
    end

    ::TokyoMetro::Api::TrainLocation::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStartingStation::Methods::Info
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStartingStation::Initializer::Info
    end
  end

end