class TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::ServiceDetail::Info < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  include ::TokyoMetro::Factory::Seed::Reference::OperationDay
  include ::TokyoMetro::Factory::Seed::Reference::BarrierFreeFacility::ServiceDetailPattern

  include ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::ServiceDetail::Common

  private

  def seed_main( get_id: false )
    operation_day_ids.each do | operation_day_id |
      h = hash_to_db( operation_day_id )
      if get_id
        @id = db_class.find_or_create_by(h).id
        seed_optional_infos_for_each_loop
      else
        db_class.find_or_create_by(h)
      end
    end
  end

  def hash_to_db( operation_day_id )
    {
      barrier_free_facility_id: @barrier_free_facility_id ,
      barrier_free_facility_service_detail_pattern_id: barrier_free_facility_service_detail_pattern_id( operation_day_id )
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_barrier_free_service_detail
  end

  def operation_day_ids
    if @info.everyday?
      [ nil ]
    else
      super( *( @info.operation_days ) )
    end
  end

  def seed_optional_infos_for_each_loop
    nil
  end

end