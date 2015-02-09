class TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Previous::List < TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::MetaClass::List

  def actual_starting_stations
    self.map( &:actual_starting_stations ).flatten
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_previous_train_relation_list
  end

end