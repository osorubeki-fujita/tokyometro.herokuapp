class TokyoMetro::Api::StationFacility::Info::Platform::Info::Common::List < Array

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  def seed( station_facility_platform_info_id )
    super( station_facility_platform_info_id , not_on_the_top_layer: true , no_display: true , display_number: false )
  end

end