class TokyoMetro::Factory::Seed::Api::RailwayLine::Info::WomenOnlyCar::Info < TokyoMetro::Factory::Seed::Api::RailwayLine::Info::MetaClass::Info

  include ::TokyoMetro::Factory::Seed::Reference::FromAndToStation
  include ::TokyoMetro::Factory::Seed::Reference::OperationDay

  private

  def seed_main
    operation_day_ids.each do | operation_day_id |
      self.class.send( method_name_for_db_instance_class ).find_or_create_by( hash_to_db( operation_day_id ) )
    end
  end

  def hash_to_db( operation_day_id )
    {
      railway_line_id: @railway_line_id ,
      from_station_id: from_station_id ,
      to_station_id: to_station_id ,
      operation_day_id: operation_day_id ,
      car_composition: @info.car_composition ,
      car_number: @info.car_number ,
      available_time_from_hour: @info.available_time_from.strftime( "%H" ).to_i ,
      available_time_from_min: @info.available_time_from.strftime( "%M" ).to_i ,
      available_time_until_hour: @info.available_time_until.strftime( "%H" ).to_i ,
      available_time_until_min: @info.available_time_until.strftime( "%M" ).to_i
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_women_only_car_infos
  end

  def operation_day_ids
    super( *( @info.operation_day ) )
  end

end