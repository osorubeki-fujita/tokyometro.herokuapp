module TokyoMetro::Refinement::Api::TrainTimetable::Info::Match

  def matches_station_timetable?( train , station_timetable_info , operation_day_in_db )
    matches_station_timetable_as_to_departure_time?( train , station_timetable_info ) and matches_station_timetable_as_to_fundamental_infos?( train , station_timetable_info , operation_day_in_db )
  end

  private

  def matches_station_timetable_as_to_departure_time?( train , station_timetable_info )
    _time_of_this_station = time_of( station_timetable_info.stations_same_as.uniq )
    _time_of_this_station.present? and _time_of_this_station[ :departure ] == train.departure_time_array
  end

  def matches_station_timetable_as_to_fundamental_infos?( train , station_timetable_info , operation_day_in_db )
    actually_terminating?( train.terminal_stations_same_as( station_timetable_info.railway_lines ) ) and operated_on?( operation_day_in_db.name_en ) and on_the_railway_line_of?( station_timetable_info.railway_lines_same_as )
  end

end