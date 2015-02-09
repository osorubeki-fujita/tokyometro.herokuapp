class TokyoMetro::Factories::Seed::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Direction < TokyoMetro::Factories::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  private

  def set_optional_infos( args )
    raise "Error" unless args.length == 1
    @barrier_free_facility_service_detail_id = args.first
  end

  def hash_to_db
    { barrier_free_facility_service_detail_id: @barrier_free_facility_service_detail_id }.merge( @info.to_h )
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_escalator_direction
  end

end