class TokyoMetro::Factory::Seed::Api::StationTimetable::Info::Fundamental::Info::Separated::Info < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable
  include ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::Fundamental::Common

  include ::TokyoMetro::Factory::Seed::Reference::Operator
  include ::TokyoMetro::Factory::Seed::Reference::RailwayLine
  include ::TokyoMetro::Factory::Seed::Reference::Station
  include ::TokyoMetro::Factory::Seed::Reference::RailwayDirection

  private

  def hash_to_db
    _railway_line_id = railway_line_id( @railway_lines )

    {
      station_timetable_id: @station_timetable_id ,
      operator_id: operator_id( @operators ) ,
      railway_line_id: _railway_line_id ,
      station_id: station_id( @stations ) ,
      railway_direction_id: railway_direction_id( _railway_line_id , @railway_directions )
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_fundamental_separated_info
  end

end