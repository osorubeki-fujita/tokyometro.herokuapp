module TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine::Info::StationTime::List

  def convert_invalid_station_names_of_yurakucho_line
    self.class.new( self.map( &:convert_invalid_station_name_of_yurakucho_line ) )
  end

end