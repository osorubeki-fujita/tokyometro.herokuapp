class TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Following::Info < TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::MetaClass::Info

  def actual_terminal_stations
    self.in_api.actual_terminal_stations
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_following_train_relation_info
  end

end