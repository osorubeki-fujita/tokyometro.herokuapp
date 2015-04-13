class TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::Info::TrainType::Pattern < TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainType::Pattern

  def initialize( *args , station_id )
    super( *args )
    @station_id = station_id
  end

  def match?( *args , station_id )
    super( *args ) and station_is?( station_id )
  end

  private

  def station_is?( station_id )
    @station_id == station_id
  end

end