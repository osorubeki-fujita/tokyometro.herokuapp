class TokyoMetro::Factories::Seed::Api::RailwayLine::List::TravelTime < TokyoMetro::Factories::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine

  private

  def method_for_seeding_each_item
    :seed_travel_time_infos
  end

end