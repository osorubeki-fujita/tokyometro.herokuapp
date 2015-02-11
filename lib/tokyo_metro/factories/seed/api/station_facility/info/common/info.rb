class TokyoMetro::Factories::Seed::Api::StationFacility::Info::Common::Info < TokyoMetro::Factories::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  def initialize( *args )
    super( *args , get_id: true )
  end

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 1 )
    @station_facility_id = args.first
  end

  def optional_variables
    [ @station_facility_id ]
  end

end