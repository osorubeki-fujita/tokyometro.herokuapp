class TokyoMetro::Factory::Seed::Api::RailwayLine::Info::TravelTime::Info < TokyoMetro::Factory::Seed::Api::RailwayLine::Info::MetaClass::Info

  include ::TokyoMetro::Factory::Seed::Reference::FromAndToStation

  private

  def method_name_for_db_instance_class
    :db_instance_class_of_travel_time_infos
  end

  def hash_to_db
    {
      railway_line_id: @railway_line_id ,
      from_station_id: from_station_id ,
      to_station_id: to_station_id ,
      necessary_time: @info.necessary_time
    }
  end

end