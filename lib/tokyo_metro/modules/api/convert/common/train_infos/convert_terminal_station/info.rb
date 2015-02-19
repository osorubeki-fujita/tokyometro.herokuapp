# @note {::TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertTerminalStation#.set_modules} により、{::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info}, {::TokyoMetro::Api::TrainTimetable::Info} へ include される。
module TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertTerminalStation::Info

  private

  def convert_terminal_station( invalid , valid )
    @terminal_station = convert_station( @terminal_station , invalid , valid )
  end

end