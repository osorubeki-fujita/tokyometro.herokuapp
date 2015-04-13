# @note {::TokyoMetro::Factory::Seed::Api::StationTrainTime::TrainInStationTimetable#find_and_get_train_timetable_infos_of_this_train} の内部変数に対して include し、特異メソッドを定義する。
module TokyoMetro::Refinement::Api::StationTimetable::Info::TrainTime::Info::TerminalStationsSameAs

  def terminal_stations_same_as( railway_lines )
    if /\.Wakoshi\Z/ === @terminal_station
      ::Station.where(
        railway_line_id: railway_lines.pluck( :id ) ,
        name_in_system: "Wakoshi"
      ).pluck( :same_as )
    else
      [ @terminal_station ]
    end
  end

end