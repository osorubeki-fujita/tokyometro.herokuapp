class TokyoMetro::Factory::Seed::Api::TrainTimetable::List::ArrivalTimes::RomanceCar < TokyoMetro::Factory::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  private

  def method_for_seeding_each_item
    :seed_arrival_times_of_romance_car
  end

end