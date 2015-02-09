module TokyoMetro::Factories::Seed::Api::StationFacility::Info::Platform::Info::Common::SetOptionalVariables

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 1
    @station_facility_platform_info_id = variables.first
  end

  def optional_variables
    [ @station_facility_platform_info_id ]
  end

end