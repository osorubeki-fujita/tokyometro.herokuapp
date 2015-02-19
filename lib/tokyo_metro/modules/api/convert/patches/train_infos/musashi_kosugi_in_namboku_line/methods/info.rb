# @note {::TokyoMetro::Modules::Api::Convert::Patches::TrainInfos::MusashiKosugiInNambokuLine#.set_modules} により、{::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info}, {::TokyoMetro::Api::TrainTimetable::Info} へ include される。
module TokyoMetro::Modules::Api::Convert::Patches::TrainInfos::MusashiKosugiInNambokuLine::Methods::Info

  private

  def convert_terminal_station_to_musashi_kosugi_in_tokyu_meguro_line
    convert_terminal_station( "odpt.Station:Tokyu.Toyoko.MusashiKosugi" , "odpt.Station:Tokyu.Meguro.MusashiKosugi" )
  end

end