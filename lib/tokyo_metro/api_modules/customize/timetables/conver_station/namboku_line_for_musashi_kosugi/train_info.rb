# @note {::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::NambokuLineForMusashiKosugil#.set_modules} により、{::TokyoMetro::Api::StationTimetable::Info::Train::Info} へ include される。
module TokyoMetro::ApiModules::Customize::Timetables::ConvertStation::NambokuLineForMusashiKosugi::TrainInfo

  private

  def convert_terminal_station_to_musashi_kosugi_in_tokyu_meguro_line
    convert_terminal_station( "odpt.Station:Tokyu.Toyoko.MusashiKosugi" , "odpt.Station:Tokyu.Meguro.MusashiKosugi" )
  end

end