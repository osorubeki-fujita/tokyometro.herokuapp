module TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine::List

  def move_station_time_infos_from_invalid_fukutoshin_line_trains_in_yurakucho_line
    invalid_trains = self.select( &:invalid_fukutoshin_line_trains_on_yurakucho_line? )
    invalid_trains.each do | invalid_train |
      valid_train = invalid_train.valid_fukutoshin_line_train( self )
      valid_station_times = ::TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine.factory_of_valid_station_times_of_weekdays.valid_station_times_of_weekdays( invalid_train , valid_train )
      valid_train.set_valid_station_times_of_weekdays( valid_station_times )
    end
    return self
  end

  def delete_invalid_fukutoshin_line_trains_in_yurakucho_line
    self.delete_if( &:invalid_fukutoshin_line_trains_on_yurakucho_line? )
  end

  def select_valid_fukutoshin_line_train_info_as_for_invalid_train_in_yurakucho_line( train_number_of_invalid_train )
    self.find { | train | train.valid_fukutoshin_line_train_info_as_for_invalid_train_in_yurakucho_line( train_number_of_invalid_train ) }
  end

end