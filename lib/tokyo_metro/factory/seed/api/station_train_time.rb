# 列車時刻の情報をDBに流し込むためのクラス
class TokyoMetro::Factory::Seed::Api::StationTrainTime

  include ::TokyoMetro::ClassNameLibrary::Api::StationTrainTime

  def initialize( info )
    @info = info
  end

  def seed
    seed_main
    seed_optional_infos
    check_validity_after_finish_seeding

    return nil
  end

  def self.process( info )
    self.new( info ).seed
  end

  def self.check_number( *symbol_of_railway_lines )
    ::TokyoMetro::Factory::Seed::Api::StationTrainTime::Checker.check_number( *symbol_of_railway_lines )
  end

  def self.destroy!( *symbol_of_railway_lines )
    ::TokyoMetro::Factory::Seed::Api::StationTrainTime::Checker.destroy!( *symbol_of_railway_lines )
  end

  def self.display_railway_line_info_in_db( *symbol_of_railway_lines )
    ::TokyoMetro::Factory::Seed::Api::StationTrainTime::Checker.display_railway_line_info_in_db( *symbol_of_railway_lines )
  end

  def self.check_chiyoda_line_info_in_db
    ::TokyoMetro::Factory::Seed::Api::StationTrainTime::Checker.display_railway_line_info_in_db( :chiyoda )
  end

  def self.compare_chiyoda_line_info_in_db_and_api
    ary = ::Array.new

    ::TokyoMetro::Api.train_timetables.chiyoda.each do | train_timetable |
      train_timetable_instance_in_db = ::TrainTimetable.find_by_same_as( train_timetable.same_as )

      if train_timetable_instance_in_db.nil?
        raise "Error: The train timetable of \"#{ train_timetable.same_as }\" does not exist in the db."
      end

      number_of_station_train_times_in_db = train_timetable_instance_in_db.station_train_times.length
      number_of_station_train_times_in_api = train_timetable.number_of_station_times

      unless number_of_station_train_times_in_db == number_of_station_train_times_in_api
        str_ary = [
          "\"#{train_timetable.same_as}\"" ,
          "(#{train_timetable.train_type})" ,
          "---" ,
          "in db: #{ number_of_station_train_times_in_db }" ,
          "/" ,
          "api : #{ number_of_station_train_times_in_api }" ,
          diff_to_s( number_of_station_train_times_in_db , number_of_station_train_times_in_api )
        ]
        ary << str_ary.join( " " )
      end

    end
    puts ary
    return nil
  end

  private

  # DB への流し込みを行うインスタンスメソッド
  # @return [nil]
  def seed_main
    seed_train_times_in_each_station
  end

  def seed_optional_infos
    seed_arrival_times_of_romance_car
    seed_arrival_times_of_last_station_in_tokyo_metro
  end

  def check_validity_after_finish_seeding
    check_validity_of_station_timetables
    check_validity_of_train_timetables
  end

  # @note 駅別・方面別の個別の時刻表の処理
  # @note {TokyoMetro::Api::StationTimetable::Info#seed_train_times} を呼び出す。
  def seed_train_times_in_each_station
    @info.station_timetables.seed_train_times( @info.train_timetables )
  end

  # 到着時刻をDBに流し込むメソッド (1) - 特急ロマンスカーの各停車駅（終着駅以外）
  # @note {#seed_additional_arrival_times} を経由し、{TokyoMetro::Api::TrainTimetable::Info#seed_arrival_times_of_romance_car} を実行する。
  # @note 終着駅の処理は {#seed_arrival_times_of_last_station_in_tokyo_metro_for_each_train} で行う。
  def seed_arrival_times_of_romance_car
    @info.train_timetables.send( __method__ )
  end

  # 到着時刻をDBに流し込むメソッド (2) - 東京メトロ線内の最後の駅
  # @note {#seed_additional_arrival_times} を経由し、{TokyoMetro::Api::TrainTimetable::Info#seed_arrival_times_of_last_station_in_tokyo_metro} を実行する。
  def seed_arrival_times_of_last_station_in_tokyo_metro
    @info.train_timetables.send( __method__ )
  end

  def check_validity_of_station_timetables
    ary = ::Array.new
    @info.station_timetables.each do | timetable |
      timetable.combination_of_timetable_types_and_operation_days.each do | timetable_in_a_day , operation_day_in_db |
        timetable_in_a_day.each do | train |
          unless train.seed_completed?
            message_ary = ::Array.new
            message_ary << "\[Error\]"
            message_ary << "\[#{ operation_day_in_db.name_en }\]".ljust(24)
            message_ary << timetable.same_as.ljust(48)
            message_ary << "#{ train.departure_time.hour }:#{ train.departure_time.min }".ljust(8)
            message_ary << train.terminal_station
            ary << message_ary.join( " " )
          end
        end
      end
    end
    display_info_of_validity_check( ary , "Timetables" )
  end

  def check_validity_of_train_timetables
    ary = ::Array.new
    @info.train_timetables.each do | train_timetable |
      train_timetable.valid_list.each do | station_time |
        unless station_time.seed_completed?
          message_ary = ::Array.new
          message_ary << "\[Error\]"
          message_ary << train_timetable.same_as.ljust(72)
          message_ary << station_time.station.ljust(48)
          message_ary << station_time.time.to_s
          ary << message_ary.join( " " )
        end
      end
    end
    display_info_of_validity_check( ary , "Train Timetables" )
  end

  def display_info_of_validity_check( ary , title )
    if ary.present?
      puts "● #{ title }"
      puts ""
      ary.each do | info |
        puts info
      end
      puts ""
    end
  end

  class << self

    private

    def diff_to_s( number_of_station_train_times_in_db , number_of_station_train_times_in_api )
      diff = number_of_station_train_times_in_db - number_of_station_train_times_in_api
      if diff > 0
        diff_to_s = "(+#{diff})"
      else
        diff_to_s = "(#{diff})"
      end
    end

  end

end