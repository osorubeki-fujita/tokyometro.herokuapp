module TokyoMetro::ApiModules::Convert::Customize::TrainInfos::RomanceCar

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::RomanceCar::Info
    end

    ::TokyoMetro::Api::TrainLocation::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::RomanceCar::Info
    end
  end

end