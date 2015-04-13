class TokyoMetro::Factory::Seed::Api::StationFacility::List::Platform < TokyoMetro::Factory::Seed::Api::StationFacility::List::Common

  private

  def method_for_seeding_each_item
    :seed_platform_infos
  end

end