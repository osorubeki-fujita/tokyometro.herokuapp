module TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::ToeiMitaLine

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::ToeiMitaLine::Info
    end
  end

end