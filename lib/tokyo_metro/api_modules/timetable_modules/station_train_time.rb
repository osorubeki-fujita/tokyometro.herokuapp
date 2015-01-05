# @note この名前空間に直接属するメソッドは、DBへの流し込み状況のチェックやDBのデータの削除に用いる。
module TokyoMetro::ApiModules::TimetableModules::StationTrainTime

  def self.check_number( *symbol_of_railway_lines )
    h = information_hash_of_number( symbol_of_railway_lines )

    if symbol_of_railway_lines == [ :yurakucho , :fukutoshin ]
      puts h[ :ids_of_station_train_times_from_train_timetables ].length

      # 和光市着（副都心線） - ::Timetable とはリンクしていないので、そもそも重複しない
      # h[ :ids_of_station_train_times_from_train_timetables ] -= ::StationTrainTime.where(
        # arrival_info_of_last_station_in_tokyo_metro: true ,
        # last_station_in_tokyo_metro_id: ::Station.where( same_as: "odpt.Station:TokyoMetro.Fukutoshin.Wakoshi" ).pluck( :id )
      # ).pluck( :id )

      # puts h[ :ids_of_station_train_times_from_train_timetables ].length

      # 和光市～氷川台発（副都心線）
      station_timetable_ids_of_fukutoshin_line_between_wakoshi_and_hikawadai = ::Timetable.where(
        station_id: ::Station.where( same_as: %W( Wakoshi ChikatetsuNarimasu ChikatetsuAkatsuka Heiwadai Hikawadai ).map { | station | "odpt.Station:TokyoMetro.Fukutoshin.#{station}" } )
      ).pluck( :id )

      h[ :ids_of_station_train_times_from_train_timetables ] -= ::StationTrainTime.where(
        timetable_id: station_timetable_ids_of_fukutoshin_line_between_wakoshi_and_hikawadai
      ).pluck( :id )

      puts h[ :ids_of_station_train_times_from_train_timetables ].length

      # 小竹向原発（副都心線 和光市方面）
      station_timetable_id_of_kotakemukaihara_on_fukutoshin_line_for_wakoshi = ::Timetable.find_by(
        same_as: "odpt.StationTimetable:TokyoMetro.Fukutoshin.KotakeMukaihara.Wakoshi"
      ).id

      h[ :ids_of_station_train_times_from_train_timetables ] -= ::StationTrainTime.where(
        timetable_id: station_timetable_id_of_kotakemukaihara_on_fukutoshin_line_for_wakoshi
      ).pluck( :id )

      puts h[ :ids_of_station_train_times_from_train_timetables ].length

      h[ :ids_of_station_train_times_from_train_timetables ] = h[ :ids_of_station_train_times_from_train_timetables ].sort
    end

    inspect_information_of_number(h)
    if match?(h)
      puts "● Match"
    else
      puts "○ Not match"
    end

    return nil
  end

  def self.destory( *symbol_of_railway_lines )
    h = information_hash_of_number( symbol_of_railway_lines )
    inspect_information_of_number(h)

    if h[ :ids_of_station_train_times_from_station_timetables ] == h[ :ids_of_station_train_times_from_train_timetables ]
      puts "● The ids of \'station_train_times\' from \'station_timetables\' and that from \'train_timetables\' are the same. -> Destroy\!"
    else
      puts "○ The ids of \'station_train_times\' from \'train_timetables\' and from \'station_timetables\' are different. -> Destroy\?"
    end
    a = gets.chomp
    h[ :ids_of_station_train_times_from_train_timetables ].each do | station_train_time_id |
      ::StationTrainTime.find( station_train_time_id ).destroy
    end

    return nil
  end

  def self.check_chiyoda_line_info_in_db
    station_timetables = ::TokyoMetro::Api.station_timetables.chiyoda
    train_timetables = ::TokyoMetro::Api.train_timetables.chiyoda

    i = 0

    puts "● Station timetable"
    station_timetables.each do | timetable |
      timetable.combination_of_timetable_types_and_operation_days.each do | timetable_in_a_day , operation_day |
        timetable_in_a_day.each do | train |
          unless train.seed_completed?
            puts [ "\[Error\]" , "\[#{ operation_day }\]".ljust(24) , timetable.same_as.ljust(48) , "#{ train.departure_time.hour }:#{ train.departure_time.min }".ljust(8) , train.terminal_station ].join( " " )
            i += 1
          end
        end
      end
    end
    if i == 0
      puts "All train datas are already seed."
    else
      puts "#{i} train datas are not seed yet."
    end

    i = 0

    puts "● Train timetable"
    train_timetables.each do | train_timetable |
      train_timetable.valid_list.each do | station_time |
        unless station_time.seed_completed?
          puts [ "\[Error\]" , train_timetable.same_as.ljust(72) , station_time.station.ljust(48) , station_time.time.to_s ].join( " " )
            i += 1
        end
      end
    end
    if i == 0
      puts "All station train time datas are already seed."
    else
      puts "#{i} station train time datas are not seed yet."
    end

    return nil
  end

  def self.compare_chiyoda_line_info_in_db_and_api
    ary = ::Array.new

    ::TokyoMetro::Api.train_timetables.chiyoda.each do | train_timetable |
      train_timetable_instance_in_db = ::TrainTimetable.find_by_same_as( train_timetable.same_as )

      if train_timetable_instance_in_db.nil?
        raise "Error: The train timetable of \"#{ train_timetable.same_as }\" does not exist in the db."
      end

      unless train_timetable_instance_in_db.station_train_times.length == train_timetable.valid_list.length
        number_of_station_train_times_in_db = train_timetable_instance_in_db.station_train_times.length
        number_of_station_train_times_in_api = train_timetable.valid_list.length
        diff = number_of_station_train_times_in_db - number_of_station_train_times_in_api
        if diff > 0
          diff_to_s = "(+#{diff})"
        else
          diff_to_s = "(#{diff})"
        end
        ary << "\"#{train_timetable.same_as}\" (#{train_timetable.train_type}) --- in db: #{ number_of_station_train_times_in_db } / api : #{ number_of_station_train_times_in_api } #{diff_to_s}"
      end

    end
    puts ary
    return nil
  end

  class << self

    private

    def information_hash_of_number( *symbol_of_railway_lines )
      symbol_of_railway_lines = symbol_of_railway_lines.flatten
      class << symbol_of_railway_lines
        include ::TokyoMetro::ExtendBuiltinLibraries::SymbolModule::RailwayLine::List
      end

      ids_of_railway_lines = ::RailwayLine.where( same_as: symbol_of_railway_lines.to_railway_lines_same_as ).pluck( :id )

      ids_of_station_timetables_on_railway_lines = ::Timetable.where( railway_line_id: ids_of_railway_lines ).pluck( :id )
      ids_of_train_timetables_on_railway_lines = ::TrainTimetable.where( railway_line_id: ids_of_railway_lines ).pluck( :id )

      ids_of_station_train_times_from_station_timetables = ::StationTrainTime.where( timetable_id: ids_of_station_timetables_on_railway_lines ).pluck( :id ).sort
      ids_of_station_train_times_from_train_timetables = ::StationTrainTime.where( train_timetable_id: ids_of_train_timetables_on_railway_lines ).pluck( :id ).sort

      number_of_train_datas_from_api = ::TokyoMetro::Api.train_timetables.send( :select_railway_line , *symbol_of_railway_lines ).map { | train_timetable |
        train_timetable.valid_list.length
      }.inject( :+ )

      {
        ids_of_railway_lines: ids_of_railway_lines ,
        ids_of_station_timetables_on_railway_lines: ids_of_station_timetables_on_railway_lines ,
        ids_of_train_timetables_on_railway_lines: ids_of_train_timetables_on_railway_lines ,
        ids_of_station_train_times_from_station_timetables: ids_of_station_train_times_from_station_timetables ,
        ids_of_station_train_times_from_train_timetables: ids_of_station_train_times_from_train_timetables ,
        number_of_train_datas_from_api: number_of_train_datas_from_api
      }
    end

    def inspect_information_of_number(h)
      puts "- StationTrainTimes from station timetables".ljust(64) + " "+ h [ :ids_of_station_train_times_from_station_timetables ].length.to_s.rjust(5)
      puts "* StationTrainTimes from train timetables".ljust(64) + " "+ h[ :ids_of_station_train_times_from_train_timetables ].length.to_s.rjust(5)
      puts "* Number of datas from api".ljust(64) + " "+ h [ :number_of_train_datas_from_api ].to_s.rjust(5)
    end

    def match?(h)
      h[ :ids_of_station_train_times_from_train_timetables ].length == h[ :number_of_train_datas_from_api ]
    end

  end

end