module TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::FukutoshinLineForWakoshi::Train

  def convert_terminal_station_to_wakoshi_in_fukutoshin_line
    convert_terminal_station( *( ::TokyoMetro::CommonModules::Dictionary::Station::StringList.wakoshi ) )
  end

end