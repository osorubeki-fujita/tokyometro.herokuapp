# @note {TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::NambokuLineForMusashiKosugi#.set_modules} により {::TokyoMetro::Api::TrainTimetable::Info} へ include される。
module TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::NambokuLineForMusashiKosugi::Info

  def initialize( id_urn , same_as , dc_date , train_number , railway_line , operator ,
  train_type , railway_direction , starting_station , terminal_station , train_owner ,
  weekdays , saturdays , holidays )
    super
    if namboku_line?
      convert_starting_station_to_musashi_kosugi_in_tokyu_meguro_line
      convert_terminal_station_to_musashi_kosugi_in_tokyu_meguro_line
    end
  end

  private

  # @note {::TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::Fundamental::Info#convert_starting_station} を用いる。
  # @note このモジュール {::TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::NambokuLineForMusashiKosugi::Info} と {::TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::Fundamental::Info} はいずれも {::TokyoMetro::Api::TrainTimetable::Info}に include される。
  def convert_starting_station_to_musashi_kosugi_in_tokyu_meguro_line
    convert_starting_station( "odpt.Station:Tokyu.Toyoko.MusashiKosugi" , "odpt.Station:Tokyu.Meguro.MusashiKosugi" )
  end

end