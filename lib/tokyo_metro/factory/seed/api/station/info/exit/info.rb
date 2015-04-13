class TokyoMetro::Factory::Seed::Api::Station::Info::Exit::Info < TokyoMetro::Factory::Seed::Api::Station::Info::Common::Info

  include ::TokyoMetro::Factory::Seed::Reference::Point

  private

  def hash_to_db
    {
      point_id: point_id ,
      station_id: @station_id
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_exit
  end

end