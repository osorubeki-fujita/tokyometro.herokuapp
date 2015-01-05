module TokyoMetro::ApiModules::Customize::TrainTimetable::TrainType

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::TrainTimetable::TrainType::Info
    end
  end

end