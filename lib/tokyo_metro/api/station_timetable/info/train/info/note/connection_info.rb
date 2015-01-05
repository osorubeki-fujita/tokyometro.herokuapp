class TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::ConnectionInfo

  def initialize( station , connection )
    @station = station
    @connection = connection
  end
  attr_reader :station , :connection

  def seed_and_get_id( railway_line_instance )
    station_instance = ::Station.find_by( name_ja: @station , railway_line_id: railway_line_instance.id )
    connection_info_h = {
      station_id: station_instance.id ,
      connection: @connection ,
      note: self.to_s
    }
    ::TimetableConnectionInfo.find_or_create_by( connection_info_h ).id
  end

  def to_s
    ""
  end

end