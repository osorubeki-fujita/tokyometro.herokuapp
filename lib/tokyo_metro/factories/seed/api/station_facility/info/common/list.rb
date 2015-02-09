class TokyoMetro::Factories::Seed::Api::StationFacility::Info::Common::List < TokyoMetro::Factories::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 1
    @station_facility_id = variables.first
  end

  def optional_variables
    [ @station_facility_id ]
  end

end