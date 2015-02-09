module TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ToeiMitaLine

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ToeiMitaLine::Info
    end

    ::TokyoMetro::Api::TrainLocation::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ToeiMitaLine::Info
    end
  end

end