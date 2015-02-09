module TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::ChiyodaBranchLine

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::ChiyodaBranchLine::Info
    end
  end

end