class TokyoMetro::Api::StationFacility::Info::Platform::Info::BarrierFree::Info < TokyoMetro::Api::StationFacility::Info::Platform::Info::Common::Info

  def initialize( facility )
    @facility = facility
  end

  attr_reader :facility

  def self.factory_for_this_class
    factory_for_generating_platform_barrier_free_info_from_string
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_platform_info_barrier_free_info
  end

end