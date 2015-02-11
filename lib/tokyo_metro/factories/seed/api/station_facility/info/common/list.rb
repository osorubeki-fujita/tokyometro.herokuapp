class TokyoMetro::Factories::Seed::Api::StationFacility::Info::Common::List < TokyoMetro::Factories::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 1 )
    @station_facility_id = args.first
  end

  def optional_variables
    [ @station_facility_id ]
  end

end