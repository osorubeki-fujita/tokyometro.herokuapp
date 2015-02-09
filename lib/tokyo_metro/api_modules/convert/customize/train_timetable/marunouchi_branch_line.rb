module TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::MarunouchiBranchLine

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::MarunouchiBranchLine::Info
    end
  end

end