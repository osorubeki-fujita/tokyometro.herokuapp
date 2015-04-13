class TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::SurroundingArea::Info < TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::Common::Info

  include ::TokyoMetro::Factory::Seed::Reference::SurroundingArea

  private

  def hash_to_db
    {
      station_facility_platform_info_id: @station_facility_platform_info_id ,
      surrounding_area_id: surrounding_area_id
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_platform_info_surrounding_area
  end

end