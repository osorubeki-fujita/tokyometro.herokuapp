class TokyoMetro::Factories::Seed::Api::StationFacility::Info::Common::Info < TokyoMetro::Factories::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  def initialize( *args )
    super( *args , get_id: true )
  end

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 1
    @station_facility_id = variables.first
  end

  def optional_variables
    [ @station_facility_id ]
  end

end