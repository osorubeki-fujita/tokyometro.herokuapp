class TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Previous::Info < TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::MetaClass::Info

  def actual_starting_stations
    self.in_api.actual_starting_stations
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_previous_train_relation_info
  end

end