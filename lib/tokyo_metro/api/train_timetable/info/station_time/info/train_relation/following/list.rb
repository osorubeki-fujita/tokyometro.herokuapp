class TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Following::List < TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::MetaClass::List

  def actual_terminal_stations
    self.map( &:actual_terminal_stations ).flatten
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_following_train_relation_list
  end

end