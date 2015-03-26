module ForRails::StationTimetables::GroupByRailwayLine

  def group_by_railway_line
    h = ::Hash.new
    railway_line_ids = self.map { | station_timetable |
      station_timetable.railway_lines.pluck( :id )
    }.flatten.uniq.sort
    self.each do | station_timetable |
      railway_line_ids = station_timetable.station_timetable_fundamental_infos.pluck( :railway_line_id )
      railway_line_ids.each do | railway_line_id |
        if h[ railway_line_id ].nil?
          h[ railway_line_id ] = ::Array.new
        end
        h[ railway_line_id ] << station_timetable
      end
    end
    h.sort_keys
  end

end