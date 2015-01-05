module TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine::List

  def move_station_time_infos_from_invalid_fukutoshin_line_trains_in_yurakucho_line
    invalid_trains = self.select( &proc_to_get_invalid_fukutoshin_line_trains_in_yurakucho_line )
    invalid_trains.each do | invalid_train |
      valid_train = invalid_train.valid_fukutoshin_line_train( self )
      factory = ::TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine.factory_of_valid_station_times_of_weekdays
      valid_station_times = factory.valid_station_times_of_weekdays( invalid_train , valid_train )
      valid_train.set_valid_station_times_of_weekdays( valid_station_times )
    end
    return self
  end

  def delete_invalid_fukutoshin_line_trains_in_yurakucho_line
    self.delete_if( &proc_to_get_invalid_fukutoshin_line_trains_in_yurakucho_line )
  end

  def select_valid_fukutoshin_line_train_info_as_for_invalid_train_in_yurakucho_line( train_number_of_invalid_train )
    self.find { | train | train.valid_fukutoshin_line_train_info_as_for_invalid_train_in_yurakucho_line( train_number_of_invalid_train ) }
  end

  private

  def proc_to_get_invalid_fukutoshin_line_trains_in_yurakucho_line
    Proc.new { | train | train.invalid_fukutoshin_line_trains_on_yurakucho_line? }
  end

end