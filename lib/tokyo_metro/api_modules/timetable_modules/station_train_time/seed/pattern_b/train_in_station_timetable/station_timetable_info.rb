class TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB::TrainInStationTimetable::StationTimetableInfo

  def initialize( station_timetable_in_api )
    @station_timetable_instance = set_station_timetable_instance_in_db( station_timetable_in_api.same_as )
    @station_instance = @station_timetable_instance.station
    @railway_line_instance = @station_timetable_instance.railway_line

    @railway_lines_same_as = set_railway_lines_same_as
    @station_instances = set_station_instances
  end

  attr_reader :station_timetable_instance
  
  # @return [::Station]
  attr_reader :station_instance
  
  # @return [::RailwayLine]
  attr_reader :railway_line_instance
  
  attr_reader :railway_lines_same_as
  attr_reader :station_instances

  include ::TokyoMetro::CommonModules::Decision::CurrentStation

  def instance_of_actual_station_in_api( train_timetable )
    case @station_instances.length
    when 1
      @station_instance
    else
      @station_instances.find { | station_instance |
        train_timetable.stopping_stations.include?( station_instance.same_as )
      }
    end
  end

  # 列車時刻表から、このインスタンスに対応する駅の停車時刻を取得するメソッド
  # @param train_timetable [::TokyoMetro::Api::TrainTimetable::Info] 列車時刻表 (API) のインスタンス
  # @return [::Hash] 停車する場合
  # @return [nil] 停車しない場合
  def stopping_time( train_timetable )
    @station_instances.map { | station_instance |
      train_timetable.time_of( station_instance.same_as )
    }.find { | time |
      time.present?
    }
  end

  # インスタンス変数 railway_lines_same_as の情報を文字列に変換して返すメソッド
  # @return [::String]
  def railway_lines_to_s
    @railway_lines_same_as.join( " / " )
  end

  # インスタンス変数 station_instances の情報を文字列に変換して返すメソッド
  # @return [::String]
  def stations_to_s
    @station_instances.map { | station_instance | station_instance.same_as }.join( " / " )
  end

  private

  def set_station_timetable_instance_in_db( station_timetable_in_api_same_as )
    station_timetable_instance = ::Timetable.find_by_same_as( station_timetable_in_api_same_as )

    if station_timetable_instance.nil?
      puts "Station Timetable Instance of \"#{ station_timetable_in_api_same_as }\" does not exist in the db."
      puts "Please input valid name. (example: \"odpt.StationTimetable:TokyoMetro.MarunouchiBranch.Nakanosakaue\" )"
      station_timetable_in_api_same_as = gets.chomp
      set_station_timetable_instance_in_db( station_timetable_in_api_same_as )
    end

    return station_timetable_instance
  end

  def set_railway_lines_same_as
    ary_m = ::TokyoMetro::CommonModules::Dictionary::RailwayLine::StringList.marunouchi_main_and_branch_line_same_as
    ary_yf = ::TokyoMetro::CommonModules::Dictionary::RailwayLine::StringList.yurakucho_and_fukutoshin_line_same_as
    if ary_m.include?( @railway_line_instance.same_as )
      ary_m
    elsif ary_yf.include?( @railway_line_instance.same_as )
      ary_yf
    else
      [ @railway_line_instance.same_as ]
    end
  end

  def set_station_instances
    if between_honancho_and_nakano_sakaue? or between_wakoshi_and_kotake_mukaihara?
      @railway_lines_same_as.map { | railway_line |
        ::Station.find_by(
          railway_line_id: ::RailwayLine.find_by( same_as: railway_line ).id ,
          name_in_system: @station_instance.name_in_system
        )
      }.select { | station |
        station.present?
      }
    else
      [ @station_instance ]
    end
  end

  def station_same_as__is_in?( *variables )
    super( *variables , @station_instance.same_as )
  end

end