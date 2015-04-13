module TokyoMetro::Factory::Seed::Reference::BarrierFreeFacility::ServiceDetailPattern

  private

  def barrier_free_facility_service_detail_pattern_in_db( operation_day_id , whole = nil , search_by: @info )
    h = {
      operation_day_id: operation_day_id
    }.merge( search_by.time_to_h )

    if whole.present?
      whole.find_or_create_by(h)
    else
      self.class.db_instance_class_of_barrier_free_service_detail_pattern.find_or_create_by(h)
    end
  end

  def barrier_free_facility_service_detail_pattern_id( operation_day_id , whole = nil , search_by: @info )
    _in_db = barrier_free_facility_service_detail_pattern_in_db( operation_day_id , whole , search_by: search_by )
    _in_db.id
  end

end