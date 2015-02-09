# @note {TokyoMetro::ApiModules::Convert::Patches::TrainTimetable::MusashiKosugiInNambokuLine#.set_modules} により {TokyoMetro::Api::TrainTimetable::Info} へ prepend される。
module TokyoMetro::ApiModules::Convert::Patches::TrainInfos::MusashiKosugiInNambokuLine::Initializer::Info

  def initialize( *variables )
    super( *variables )
    if namboku_line?
      convert_starting_station_to_musashi_kosugi_in_tokyu_meguro_line
      convert_terminal_station_to_musashi_kosugi_in_tokyu_meguro_line
    end
  end

  private

  # @note {::TokyoMetro::ApiModules::Convert::Common::TrainInfos::ConvertStartingStation::Info#convert_starting_station} を用いる。
  # @note このモジュール {::TokyoMetro::ApiModules::Convert::Patches::TrainInfos::MusashiKosugiInNambokuLine::Initializer::Info} と {::TokyoMetro::ApiModules::Convert::Common::TrainInfos::ConvertStartingStation::Info} はいずれも {::TokyoMetro::Api::TrainTimetable::Info}に include される。
  def convert_starting_station_to_musashi_kosugi_in_tokyu_meguro_line
    convert_starting_station( "odpt.Station:Tokyu.Toyoko.MusashiKosugi" , "odpt.Station:Tokyu.Meguro.MusashiKosugi" )
  end

end