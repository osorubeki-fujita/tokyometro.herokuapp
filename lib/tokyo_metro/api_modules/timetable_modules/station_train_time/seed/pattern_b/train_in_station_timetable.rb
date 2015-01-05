class TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB::TrainInStationTimetable

  # Constructor
  # @param station_timetable_info [::TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB::TrainInStationTimetable::StationTimetableInfo]
  # @param train [::TokyoMetro::Api::StationTimetable::Info::Train::Info]
  def initialize( station_timetable_info , train )
    @station_timetable_info = station_timetable_info
    @train = train
  end

  # @return [::TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB::TrainInStationTimetable::StationTimetableInfo]
  attr_reader :station_timetable_info
  
  # @return [::TokyoMetro::Api::StationTimetable::Info::Train::Info]
  attr_reader :train

  def find_and_get_train_timetable_infos_of_this_train_by( train_timetables , operation_day_instance )
    train_timetable_in_api = train_timetables.find { | train_timetable |
      match_all_informations_of?( train_timetable )  and train_timetable.operated_on?( operation_day_instance.name_en )
    }

    if train_timetable_in_api.nil?
      raise error_msg_of_finding_train_timetable_in_api( operation_day_instance )
    end

    puts train_timetable_in_api.same_as
    {
      station_timetable_instance_in_db: @station_timetable_info.station_timetable_instance ,
      train_timetable_in_db: ::TrainTimetable.find_by_same_as( train_timetable_in_api.same_as ) ,
      station_time: train_timetable_in_api.info_of( @station_timetable_info.instance_of_actual_station_in_api( train_timetable_in_api ).same_as ) ,
      operation_day: operation_day_instance
    }
  end

  private

  def terminal_station_of_train
    @train.terminal_station
  end

  # インスタンス変数 station_timetable_info の路線の情報を文字列に変換して返すメソッド
  # @return [::String]
  # @note {::TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB::TrainInStationTimetable::StationTimetableInfo#railway_lines_to_s} を呼び出す。
  def railway_lines_to_s
    @station_timetable_info.railway_lines_to_s
  end

  # インスタンス変数 station_timetable_info の駅の情報を文字列に変換して返すメソッド
  # @return [::String]
  # @note {::TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB::TrainInStationTimetable::StationTimetableInfo#stations_to_s} を呼び出す。
  def stations_to_s
    @station_timetable_info.stations_to_s
  end

  def terminal_stations_to_s
    terminal_stations_of_train_same_as.join( " / " )
  end

  def match_all_informations_of?( train_timetable )
    match_departure_time_of?( train_timetable ) and match_railway_line_of?( train_timetable ) and match_terminal_station_of?( train_timetable )
  end

  def match_departure_time_of?( train_timetable )
    h_time = time_of_this_station( train_timetable )
    h_time.present? and h_time[ :departure ] == train_departure_time
  end

  def train_departure_time
    @train.departure_time_array
  end

  def match_railway_line_of?( train_timetable )
    @station_timetable_info.railway_lines_same_as.include?( train_timetable.railway_line )
  end

  def match_terminal_station_of?( train_timetable )
    terminal_stations_of_train_same_as.any? { | station_same_as | train_timetable.bound_for?( station_same_as ) }
  end

  def terminal_stations_of_train_same_as
    wakoshi = "Wakoshi"
    if /\.#{wakoshi}\Z/ === terminal_station_of_train
      id_of_railway_lines = ::RailwayLine.where( same_as: @station_timetable_info.railway_lines_same_as ).pluck( :id )
      id_of_railway_lines.map { | id_of_railway_line | ::Station.find_by( railway_line_id: id_of_railway_line , name_in_system: wakoshi ).same_as }
    else
      [ terminal_station_of_train ]
    end
  end

  # 列車時刻表から、このインスタンスに対応する駅の停車時刻を取得するメソッド
  # @param train_timetable [::TokyoMetro::Api::TrainTimetable::Info] 列車時刻表 (API) のインスタンス
  # @note @station_timetable_info のメソッドを呼び出す。
  # @return [Hash] 停車する場合
  # @return [nil] 停車しない場合
  def time_of_this_station( train_timetable )
    @station_timetable_info.stopping_time( train_timetable )
  end

  def stop_at_this_station?( train_timetable )
    time_of_this_station( train_timetable ).present?
  end

  def error_msg_of_finding_train_timetable_in_api( operation_day_instance )
    error_message_ary = ::Array.new
    error_message_ary << "\n"
    error_message_ary << "Error: The train timetable including these informations does not exist."
    [
      [ "Depart from" , stations_to_s + " (#{ railway_lines_to_s })" ] ,
      [ "Departure time" , train_departure_time.join( ":" ) ] ,
      [ "Terminal station" , terminal_stations_to_s ] ,
      [ "Operation day" , operation_day_instance.name_en ]
    ].each do | title , info |
      error_message_ary << ( title.ljust(24) + " ... " + info )
    end
    error_message_ary.join( "\n" )
  end

end