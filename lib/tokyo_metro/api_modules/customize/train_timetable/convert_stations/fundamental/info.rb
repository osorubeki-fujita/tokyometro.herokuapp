# @note {TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::Fundamental#.set_modules} により {::TokyoMetro::Api::TrainTimetable::Info} へ include される。
module TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::Fundamental::Info

  private

  # @note {::TokyoMetro::ApiModules::Customize::Timetables::ConvertStation::Fundamental::TrainInfo#convert_station} を用いる。
  # @note このモジュール {::TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::Fundamental::Info} と {::TokyoMetro::ApiModules::Customize::Timetables::ConvertStation::Fundamental::TrainInfo} はいずれも {::TokyoMetro::Api::TrainTimetable::Info}に include される。
  def convert_starting_station( invalid , valid )
    @starting_station = convert_station( @starting_station , invalid , valid )
  end

end