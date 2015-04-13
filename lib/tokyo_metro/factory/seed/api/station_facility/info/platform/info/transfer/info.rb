class TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::Transfer::Info < TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::Common::Info

  include ::TokyoMetro::Factory::Seed::Reference::RailwayLine
  include ::TokyoMetro::Factory::Seed::Reference::RailwayDirection

  private

  def hash_to_db
    _railway_line_id = railway_line_id
    {
      station_facility_platform_info_id: @station_facility_platform_info_id ,
      railway_line_id: _railway_line_id ,
      railway_direction_id: railway_direction_id( _railway_line_id ) ,
      necessary_time: @info.necessary_time
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_platform_info_transfer_info
  end

  def railway_direction_id( _railway_line_id )
    if @info.railway_direction.present?
      super( _railway_line_id )
    else
      nil
    end
  end

end