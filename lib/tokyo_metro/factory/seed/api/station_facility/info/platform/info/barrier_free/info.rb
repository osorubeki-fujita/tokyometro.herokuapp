class TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::BarrierFree::Info < TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::Common::Info

  include ::TokyoMetro::Factory::Seed::Reference::BarrierFreeFacility::Info

  private

  def hash_to_db
    {
      station_facility_platform_info_id: @station_facility_platform_info_id ,
      barrier_free_facility_id: barrier_free_facility_id
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_platform_info_barrier_free_facility
  end

end