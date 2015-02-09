module TokyoMetro::ApiModules::Convert::Patches::StationTimetable::FukutoshinLineForWakoshi::Info::TrainTime::Info

  def convert_terminal_station_to_wakoshi_in_fukutoshin_line
    convert_terminal_station( *( ::TokyoMetro::CommonModules::Dictionary::Station::StringList.wakoshi ) )
  end

end