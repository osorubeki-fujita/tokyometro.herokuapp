module ForRails::StationTimetables::GroupByRailwayDirection

  def group_by_railway_direction
    h = ::Hash.new
    railway_direction_ids = self.map { | station_timetable |
      station_timetable.railway_directions.pluck( :id )
    }.flatten.uniq.sort
    self.each do | station_timetable |
      railway_direction_ids = station_timetable.station_timetable_fundamental_infos.pluck( :railway_direction_id )
      railway_direction_ids.each do | railway_direction_id |
        if h[ railway_direction_id ].nil?
          h[ railway_direction_id ] = ::Array.new
        end
        h[ railway_direction_id ] << station_timetable
      end
    end
    h.sort_keys
  end

end