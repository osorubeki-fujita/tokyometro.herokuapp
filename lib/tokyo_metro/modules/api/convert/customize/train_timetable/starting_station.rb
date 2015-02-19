module TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::StartingStation

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::StartingStation::Info
    end
  end

end