class TokyoMetro::Factory::Seed::Api::TrainTimetable::List::ArrivalTimes::LastStationInTokyoMetro < TokyoMetro::Factory::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  private

  def method_for_seeding_each_item
    :seed_arrival_time_of_last_station_in_tokyo_metro
  end

end