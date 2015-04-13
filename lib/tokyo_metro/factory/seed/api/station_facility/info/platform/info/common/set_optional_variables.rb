module TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::Common::SetOptionalVariables

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 1 )
    @station_facility_platform_info_id = args.first
  end

  def optional_variables
    [ @station_facility_platform_info_id ]
  end

end