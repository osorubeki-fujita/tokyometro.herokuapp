class TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Direction < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  private

  def set_optional_variables( args )
    raise "Error" unless args.length == 1
    @barrier_free_facility_service_detail_id = args.first
  end

  def hash_to_db
    {
      barrier_free_facility_service_detail_id: @barrier_free_facility_service_detail_id ,
      barrier_free_facility_escalator_direction_pattern_id: barrier_free_facility_escalator_direction_pattern_id
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_escalator_direction
  end

  def method_name_for_db_direction_pattern_instance_class
    :db_instance_class_of_escalator_direction_pattern
  end

  def barrier_free_facility_escalator_direction_pattern_id
    self.class.send( method_name_for_db_direction_pattern_instance_class ).find_or_create_by( @info.to_h ).id
  end

end