module TokyoMetro::Factory::Seed::Reference::BarrierFreeFacility::Info

  private

  def barrier_free_facility_in_db( search_by: @info.facility )
    self.class.db_instance_class_of_barrier_free_facility_info.find_by_same_as( search_by )
  end

  def barrier_free_facility_id( search_by: @info.facility )
    barrier_free_facility_in_db( search_by: search_by ).id
  end

end