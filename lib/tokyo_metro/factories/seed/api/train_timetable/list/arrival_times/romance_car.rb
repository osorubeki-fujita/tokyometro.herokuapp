class TokyoMetro::Factories::Seed::Api::TrainTimetable::List::ArrivalTimes::RomanceCar < TokyoMetro::Factories::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  private

  def method_for_seeding_each_item
    :seed_arrival_times_of_romance_car
  end

end