class TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info < TokyoMetro::Factory::Seed::Api::StationFacility::Info::Common::Info

  include ::TokyoMetro::Factory::Seed::Reference::RailwayLine
  include ::TokyoMetro::Factory::Seed::Reference::RailwayDirection

  private

  def hash_to_db
    _railway_line_id = railway_line_id
    {
      station_facility_id: @station_facility_id ,
      railway_line_id: _railway_line_id ,
      railway_direction_id: railway_direction_id( _railway_line_id ) ,
      car_composition: @info.car_composition ,
      car_number: @info.car_number
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_platform_info
  end

  def seed_optional_infos
    [ :transfer_infos , :barrier_free_facilities , :surrounding_areas ].each do | method_base_name |
      @info.send( "seed_#{ method_base_name }" , @id )
    end
  end

end