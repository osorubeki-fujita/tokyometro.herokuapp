# 始発駅の情報を扱うクラス（メタクラス）
class TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::StartingStation::Fundamental

  # Constructor
  def initialize( str )
    @station = str
  end

  # @return [String] 始発駅
  attr_reader :station
  alias :sta :station

  # インスタンスの情報を文字列に変換して返すメソッド
  # @return [String]
  def to_s
    "始発駅：#{@station}"
  end

  def seed_and_get_id( railway_line_instance )
    station_instance = ::Station.find_by( name_ja: @station , railway_line_id: railway_line_instance.id )
    starting_station_info_h = { station_id: station_instance.id }
    timetable_starting_station_info_id = ::TimetableStartingStationInfo.find_or_create_by( starting_station_info_h ).id
    puts "★ #{self.station}駅始発"
    puts ""
    return timetable_starting_station_info_id
  end

end