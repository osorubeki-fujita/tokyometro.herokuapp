module ForRails::FareTable::SplitStationInfosByStartingStationInfoId

  def fare_table_split_station_infos_by_starting_station_info_id( id_of_starting_station_info_id_included_in_this_railway_line )
    case id_of_starting_station_info_id_included_in_this_railway_line
    when self.first.id
      [ [] , self[ 1..(-1) ] ]
    when self.last.id
      [ self[ 0..(-2) ] , [] ]
    else
      position_of_starting_station_info = self.index { | station_info | station_info.id == id_of_starting_station_info_id_included_in_this_railway_line }
      [ self[ 0..( position_of_starting_station_info - 1 ) ] , self[ ( position_of_starting_station_info + 1 )..( -1 ) ] ]
    end
  end

end