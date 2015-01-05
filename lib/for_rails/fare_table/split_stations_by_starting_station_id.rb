module ForRails::FareTable::SplitStationsByStartingStationId

  def fare_table_split_stations_by_starting_station_id( id_of_starting_station_id_included_in_this_railway_line )
    case id_of_starting_station_id_included_in_this_railway_line
    when self.first.id
      [ [] , self[ 1..(-1) ] ]
    when self.last.id
      [ self[ 0..(-2) ] , [] ]
    else
      position_of_starting_station = self.index { | station | station.id == id_of_starting_station_id_included_in_this_railway_line }
      [ self[ 0..( position_of_starting_station - 1 ) ] , self[ ( position_of_starting_station + 1 )..( -1 ) ] ]
    end
  end

end