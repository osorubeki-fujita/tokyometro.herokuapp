class TokyoMetro::Factory::Seed::Api::StationTrainTime::TrainInStationTimetable::StationTimetableInfo

  def initialize( station_timetable_in_api )
    @station_timetable_in_db = set_station_timetable_in_db( station_timetable_in_api.same_as )

    @railway_lines_in_db = @station_timetable_in_db.railway_lines
    @stations_in_db = @station_timetable_in_db.stations
  end

  attr_reader :station_timetable_in_db

  attr_reader :railway_lines_in_db
  attr_reader :stations_in_db

  alias :railway_lines :railway_lines_in_db
  alias :stations :stations_in_db

  def instance_of_actual_station_in_api( train_timetable )
    _stations = stations_in_db
    case _stations.length
    when 1
      _stations.first
    else
      _stations.find { | station_in_db |
        train_timetable.stops_at?( station_in_db.same_as )
      }
    end
  end

  def railway_lines_same_as
    @railway_lines_in_db.map( &:same_as )
  end

  # インスタンス変数 railway_lines_same_as の情報を文字列に変換して返すメソッド
  # @return [::String]
  def railway_lines_to_s
    railway_lines_same_as.join( " / " )
  end

  def stations_same_as
    @stations_in_db.map( &:same_as )
  end

  # インスタンス変数 stations_in_db の情報を文字列に変換して返すメソッド
  # @return [::String]
  def stations_to_s
    stations_same_as.join( " / " )
  end

  private

  def set_station_timetable_in_db( station_timetable_in_api_same_as )
    station_timetable_in_db = ::StationTimetable.find_by_same_as( station_timetable_in_api_same_as )

    if station_timetable_in_db.nil?
      puts "Station Timetable Instance of \"#{ station_timetable_in_api_same_as }\" does not exist in the db."
      puts "Please input valid name. (example: \"odpt.StationTimetable:TokyoMetro.MarunouchiBranch.Nakanosakaue\" )"
      station_timetable_in_api_same_as = gets.chomp
      set_station_timetable_in_db( station_timetable_in_api_same_as )
    end

    return station_timetable_in_db
  end

end