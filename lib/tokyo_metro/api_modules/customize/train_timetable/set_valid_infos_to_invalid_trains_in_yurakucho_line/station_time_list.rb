module TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine::StationTimeList

  def convert_invalid_station_names_of_yurakucho_line
    self.class.new( self.map { | station_time | station_time.convert_invalid_station_name_of_yurakucho_line } )
  end

end