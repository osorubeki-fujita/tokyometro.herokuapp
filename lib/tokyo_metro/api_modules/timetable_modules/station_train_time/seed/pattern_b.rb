# 列車時刻の情報をDBに流し込むためのクラス
class TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB

  # Constructor
  # @param station_timetables [TokyoMetro::Api::StationTimetable::List <TokyoMetro::Api::StationTimetable::Info>] 流し込みの対象となる列車時刻に関連する駅時刻表
  # @param train_timetables [TokyoMetro::Api::TrainTimetable::List <TokyoMetro::Api::TrainTimetable::Info>] 流し込みの対象となる列車時刻に関連する列車時刻表
  def initialize( station_timetables , train_timetables )
    @station_timetables = station_timetables
    @train_timetables = train_timetables
  end

  # @return [TokyoMetro::Api::StationTimetable::List <TokyoMetro::Api::StationTimetable::Info>] 流し込みの対象となる列車時刻に関連する駅時刻表
  attr_reader :station_timetables

  # @return [TokyoMetro::Api::TrainTimetable::List <TokyoMetro::Api::TrainTimetable::Info>] 流し込みの対象となる列車時刻に関連する列車時刻表
  attr_reader :train_timetables

  def select_timetables( *method_names_for_selecting_railway_line )
    unless method_names_for_selecting_railway_line.empty?
      @station_timetables = self.class.send( :proc_for_select_timetables ).call( method_names_for_selecting_railway_line , @station_timetables )
      @train_timetables = self.class.send( :proc_for_select_timetables ).call( method_names_for_selecting_railway_line , @train_timetables )
    end
    return self
  end

  # 駅時刻表、列車時刻表を限定し DB への流し込みを行うクラスメソッド
  # @param method_names_for_selecting_railway_line [::Array <Symbol>] 駅時刻表、列車時刻表を限定するためのメソッドの名称（可変長引数）
  # @note method_names_for_selecting_railway_line を限定しない場合は、すべての駅時刻表・列車時刻表に対し処理を行う。
  def self.process( *method_names_for_selecting_railway_line )
    station_timetables = ::TokyoMetro::Api.station_timetables
    train_timetables = ::TokyoMetro::Api.train_timetables

    unless method_names_for_selecting_railway_line.empty?
      station_timetables = proc_for_select_timetables.call( method_names_for_selecting_railway_line , station_timetables )
      train_timetables = proc_for_select_timetables.call( method_names_for_selecting_railway_line , train_timetables )
    end

    self.new( station_timetables , train_timetables ).seed
  end

  # DB への流し込みを行うインスタンスメソッド
  # @return [nil]
  def seed
    seed__train_times_in_each_station
    seed__arrival_times_of_romance_car
    seed__arrival_times_of_last_station_in_tokyo_metro_for_each_train

    seed__check_completed_or_not__timetables
    seed__check_completed_or_not__train_timetables

    return nil
  end

  class << self

    private

    def proc_for_select_timetables
      # method_list は、method_names_for_selecting_railway_line に相当
      Proc.new { | method_list , timetables |
          method_list.map { | method | timetables.send( method ) }.flatten
      }
    end

  end

  private

  def seed__train_times_in_each_station
    # 駅別・方面別の個別の時刻表の処理〈ここから〉
    @station_timetables.each do | station_timetable |
      station_timetable_info = TrainInStationTimetable::StationTimetableInfo.new( station_timetable )

      # 各曜日の時刻の処理〈ここから〉
      station_timetable.combination_of_timetable_types_and_operation_days.each do | station_timetable_in_a_day , operation_day_name |
        operation_day_instance = ::OperationDay.find_by_name_en( operation_day_name )
        # 各列車の時刻の処理〈ここから〉
        station_timetable_in_a_day.each do | train |
          train_in_station_timetable = TrainInStationTimetable.new( station_timetable_info , train )
          hash_for_seeding_train = train_in_station_timetable.find_and_get_train_timetable_infos_of_this_train_by( @train_timetables , operation_day_instance )

          train.seed( hash_for_seeding_train )

          train.seed_completed!
          hash_for_seeding_train[ :station_time ].seed_completed!
        end
        # 各列車の時刻の処理〈ここまで〉
      end
      # 各曜日の時刻の処理〈ここまで〉
    end
    # 駅別・方面別の個別の時刻表の処理〈ここまで〉
  end

  # 到着時刻をDBに流し込むメソッド (1) - 特急ロマンスカーの各停車駅（終着駅以外）
  # @note {#seed__additional_arrival_times} を経由し、{TokyoMetro::ApiModules::TimetableModules::TrainTimetable::Info::Seed::PatternB#seed_arrival_times_of_romance_car} を実行する。
  # @note 終着駅の処理は {#seed__arrival_times_of_last_station_in_tokyo_metro_for_each_train} で行う。
  def seed__arrival_times_of_romance_car
    seed__additional_arrival_times( :seed_arrival_times_of_romance_car )
  end

  # 到着時刻をDBに流し込むメソッド (2) - 東京メトロ線内の最後の駅
  # @note {#seed__additional_arrival_times} を経由し、{TokyoMetro::ApiModules::TimetableModules::TrainTimetable::Info::Seed::PatternB#seed_arrival_times_of_last_station_in_tokyo_metro} を実行する。
  def seed__arrival_times_of_last_station_in_tokyo_metro_for_each_train
    seed__additional_arrival_times( :seed_arrival_times_of_last_station_in_tokyo_metro )
  end

  # 到着時刻の情報をDBに流し込むメソッド
  # @note {#seed__arrival_times_of_last_station_in_tokyo_metro_for_each_train}, {#seed__arrival_times_of_romance_car} で使用する。
  def seed__additional_arrival_times( method_name )
    @train_timetables.each do | train_timetable |
      train_timetable.send( method_name )
    end
  end

  def seed__check_completed_or_not__timetables
    ary = ::Array.new
    @station_timetables.each do | timetable |
      timetable.combination_of_timetable_types_and_operation_days.each do | timetable_in_a_day , operation_day |
        timetable_in_a_day.each do | train |
          unless train.seed_completed?
            ary << [ "\[Error\]" , "\[#{ operation_day }\]".ljust(24) , timetable.same_as.ljust(48) , "#{ train.departure_time.hour }:#{ train.departure_time.min }".ljust(8) , train.terminal_station ].join( " " )
          end
        end
      end
    end
    seed__check_completed_or_not__display_info( ary , "Timetables" )
  end

  def seed__check_completed_or_not__train_timetables
    ary = ::Array.new
    @train_timetables.each do | train_timetable |
      train_timetable.valid_list.each do | station_time |
        unless station_time.seed_completed?
          ary << [ "\[Error\]" , train_timetable.same_as.ljust(72) , station_time.station.ljust(48) , station_time.time.to_s ].join( " " )
        end
      end
    end
    seed__check_completed_or_not__display_info( ary , "Train Timetables" )
  end

  def seed__check_completed_or_not__display_info( ary , title )
    if ary.present?
      puts "● #{ title }"
      puts ""
      ary.each do | info |
        puts info
      end
      puts ""
    end
  end

end