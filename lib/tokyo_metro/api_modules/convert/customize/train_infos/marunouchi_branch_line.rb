module TokyoMetro::ApiModules::Convert::Customize::TrainInfos::MarunouchiBranchLine

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::MarunouchiBranchLine::Info
    end

    ::TokyoMetro::Api::TrainLocation::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainInfos::MarunouchiBranchLine::Info
    end
  end

end