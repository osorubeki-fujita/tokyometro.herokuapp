module TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine::Generate::List

  def generate( max = nil )
    ary = super( max )
    ary = ary.move_station_time_infos_from_invalid_fukutoshin_line_trains_in_yurakucho_line
    ary = ary.delete_invalid_fukutoshin_line_trains_in_yurakucho_line
    ary
  end

end