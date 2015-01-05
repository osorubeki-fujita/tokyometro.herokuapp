class TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternB::TrainTypeFactoryInEachStation < TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternA::TrainTypeFactory

  @patterns = ::Array.new

  def self.train_type_pattern_class
    ::TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternB::TrainTypeFactoryInEachStation::Pattern
  end

end