module TokyoMetro::Factories::Seed::Api::StationFacility::Info::BarrierFree::ServiceDetail::Common

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  private

  def set_optional_variables( *args )
    unless args.length == 1
      raise "Error"
    end
    @barrier_free_facility_id = args.first
  end

  def optional_variables
    [ @barrier_free_facility_id ]
  end

end