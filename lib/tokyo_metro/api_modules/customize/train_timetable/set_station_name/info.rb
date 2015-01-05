# 列車時刻表の、列車の始発駅・終着駅に関する情報を処理する機能を提供するモジュール
# @note API からの情報のカスタマイズ
# @note {::TokyoMetro::Api::TrainTimetable::Info} に対する機能
# @note {::TokyoMetro::ApiModules::Customize::TrainTimetable::SetStationName#.set_modules} により、{::TokyoMetro::Api::TrainTimetable::Info} へ include される。
module TokyoMetro::ApiModules::Customize::TrainTimetable::SetStationName::Info

  # Constructor
  # @return [::TokyoMetro::Api::TrainTimetable::Info]
  def initialize( id_urn , same_as , dc_date , train_number , railway_line , operator , train_type , railway_direction ,
    starting_station , terminal_station , train_owner , weekdays , saturdays , holidays
  )
    super
    set_starting_station_same_as_in_db
    set_terminal_station_same_as_in_db
  end

  private

  def set_starting_station_same_as_in_db
    @starting_station = ::TokyoMetro::ApiModules::TimetableModules::Common::Station.station_same_as_in_db( @starting_station , "Starting station" )
  end

  def set_terminal_station_same_as_in_db
    @terminal_station = ::TokyoMetro::ApiModules::TimetableModules::Common::Station.station_same_as_in_db( @terminal_station , "Terminal station" )
  end

end