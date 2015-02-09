module TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::StartingStation

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::StartingStation::Info
    end
  end

end