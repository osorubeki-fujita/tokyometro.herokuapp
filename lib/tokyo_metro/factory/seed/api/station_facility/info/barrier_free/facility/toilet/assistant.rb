class TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Assistant < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 1 )
    @barrier_free_facility_id = args.first
  end

  def hash_to_db
    {
      barrier_free_facility_id: @barrier_free_facility_id ,
      barrier_free_facility_toilet_assistant_pattern_id: barrier_free_facility_toilet_assistant_pattern_id
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_toilet_assistant
  end

  def barrier_free_facility_toilet_assistant_pattern_in_db
    ::BarrierFreeFacilityToiletAssistantPattern.find_or_create_by( @info.to_h )
  end

  def barrier_free_facility_toilet_assistant_pattern_id
    barrier_free_facility_toilet_assistant_pattern_in_db.id
  end

end