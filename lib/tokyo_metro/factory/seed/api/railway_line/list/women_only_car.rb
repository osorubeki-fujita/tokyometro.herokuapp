class TokyoMetro::Factory::Seed::Api::RailwayLine::List::WomenOnlyCar < TokyoMetro::Factory::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine

  private

  def method_for_seeding_each_item
    :seed_women_only_car_infos
  end

end