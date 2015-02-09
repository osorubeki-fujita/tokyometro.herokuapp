class TokyoMetro::Api::StationFacility::Info::Platform::Info::SurroundingArea::Info < TokyoMetro::Api::StationFacility::Info::Platform::Info::Common::Info

  def initialize( area_name )
    @area_name = area_name
  end

  attr_reader :area_name

  def self.factory_for_this_class
    factory_for_generating_platform_surrounding_area_info_from_string
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_platform_info_surrounding_area_info
  end

end