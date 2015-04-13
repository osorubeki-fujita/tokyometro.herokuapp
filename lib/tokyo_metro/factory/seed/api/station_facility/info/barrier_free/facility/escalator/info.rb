class TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Facility::Escalator::Info < TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Info

  private

  def seed_optional_infos
    super
    seed_availability_to_wheel_chair
  end

  def seed_availability_to_wheel_chair
    self.class.db_instance_class_of_barrier_free_facility_info.find( @id ).update( is_available_to_wheel_chair: @info.available_to_wheel_chair? )
  end

end