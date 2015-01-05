# @note {::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::Fundamental#.set_modules} により、{::TokyoMetro::Api::StationTimetable::Info::Train::Info} へ include される。
# @note {::TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::Fundamental#.set_modules} により、{::TokyoMetro::Api::TrainTimetable::Info} へ include される。
module TokyoMetro::ApiModules::Customize::Timetables::ConvertStation::Fundamental::TrainInfo

  private

  def convert_terminal_station( invalid , valid )
    @terminal_station = convert_station( @terminal_station , invalid , valid )
  end

  def convert_station( station , invalid , valid )
    if station == invalid
      valid
    else
      station
    end
  end

end