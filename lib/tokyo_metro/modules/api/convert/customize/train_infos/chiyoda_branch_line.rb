module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ChiyodaBranchLine

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ChiyodaBranchLine::Info
    end

    ::TokyoMetro::Api::TrainLocation::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ChiyodaBranchLine::Info
    end
  end

end