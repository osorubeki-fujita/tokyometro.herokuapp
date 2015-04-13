class TokyoMetro::Factory::Seed::Api::StationTrainTime::Checker

  def initialize( *symbol_of_railway_lines )
    @symbol_of_railway_lines = symbol_of_railway_lines.flatten.sort
    class << @symbol_of_railway_lines
      include ::TokyoMetro::ExtendBuiltinLibraries::SymbolModule::RailwayLine::List
    end
    @railway_line_ids = ::RailwayLine.where( same_as: @symbol_of_railway_lines.to_railway_lines_same_as ).pluck( :id )

    #--------

    @station_timetable_ids = ::StationTimetableFundamentalInfo.where( railway_line_id: @railway_line_ids ).pluck( :station_timetable_id ).sort
    @train_timetable_ids = ::TrainTimetable.where( railway_line_id: @railway_line_ids ).pluck( :id ).sort

    #--------

    @station_train_times_from_station_timetables = ::StationTrainTime.where( station_timetable_id: @station_timetable_ids ).pluck( :id ).sort
    @station_train_times_from_train_timetables = ::StationTrainTime.where( train_timetable_id: @train_timetable_ids ).pluck( :id ).sort

    @number_of_station_train_times_in_api = ::TokyoMetro::Api.train_timetables.send( :select_railway_line , *( @symbol_of_railway_lines ) ).map { | train_timetable |
      train_timetable.valid_list.length
    }.inject( :+ )
  end

  def check_number
    display_normal_info
    display_match_or_not
    return nil
  end

  def destroy!
    display_before_destroy
    a = gets.chomp
    @station_train_times_from_train_timetables.each do | station_train_time_id |
      ::StationTrainTime.find( station_train_time_id ).destroy
    end
    return nil
  end

  def display_railway_line_info_in_db
    display_station_timetable_info_in_db
    display_train_timetable_info_in_db
    return nil
  end

  [ :check_number , :destroy! , :display_railway_line_info_in_db ].each do | instance_method_name |
    eval <<-DEF
      def self.#{ instance_method_name }( *symbol_of_railway_lines )
        self.new( *symbol_of_railway_lines ).#{ instance_method_name }
      end
    DEF
  end

  private

  def symbol_for_select_timetable
    case @symbol_of_railway_lines.length
    when 1
      @symbol_of_railway_lines.first
    else
      if @symbol_of_railway_lines.length == 2 and @symbol_of_railway_lines == [ :yurakucho , :fukutoshin ].sort
        :yurakucho_or_fukutoshin
      else
        raise "Error"
      end
    end
  end

  def display_normal_info
    puts "- StationTrainTimes from station timetables".ljust(64) + " "+ @station_train_times_from_station_timetables.length.to_s.rjust(5)
    puts "* StationTrainTimes from train timetables".ljust(64) + " "+ @station_train_times_from_train_timetables.length.to_s.rjust(5)
    puts "* Number of datas from api".ljust(64) + " "+ @number_of_station_train_times_in_api.to_s.rjust(5)
  end

  def display_match_or_not
    if @station_train_times_from_train_timetables.length == @number_of_station_train_times_in_api
      puts "● Match"
    else
      puts "○ Not match"
    end
  end

  def display_before_destroy
    display_normal_info
    display_before_destroy__question
  end

  def display_before_destroy__question
    if @station_train_times_from_station_timetables == @station_train_times_from_train_timetables
      puts "● The ids of \'station_train_times\' from \'station_timetables\' and that from \'train_timetables\' are the same. -> Destroy\!"
    else
      puts "○ The ids of \'station_train_times\' from \'train_timetables\' and from \'station_timetables\' are different. -> Destroy\?"
    end
    puts "\[Put Enter\]"
  end

  [ :station_timetables , :train_timetables ].each do | method_name |
    eval <<-DEF
      def #{method_name}
        ::TokyoMetro::Api.#{method_name}.send( symbol_for_select_timetable )
      end
    DEF
  end

  def display_station_timetable_info_in_db
    i = 0

    puts "● Station timetable"
    station_timetables.each do | timetable |
      timetable.combination_of_timetable_types_and_operation_days.each do | timetable_in_a_day , operation_day_in_db |
        timetable_in_a_day.each do | train |
          unless train.seed_completed?
            puts [ "\[Error\]" , "\[#{ operation_day_in_db.name_en }\]".ljust(24) , timetable.same_as.ljust(48) , "#{ train.departure_time.hour }:#{ train.departure_time.min }".ljust(8) , train.terminal_station ].join( " " )
            i += 1
          end
        end
      end
    end
    if i == 0
      puts "All train time datas are already seed."
    else
      puts "#{i} train time datas are not seed yet."
    end
  end

  def display_train_timetable_info_in_db
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
  end

end

__END__

    if symbol_of_railway_lines == [ :yurakucho , :fukutoshin ]
      puts h[ :station_train_times_from_train_timetables ].length

      # 和光市着（副都心線） - ::StationTimetable とはリンクしていないので、そもそも重複しない
      # h[ :station_train_times_from_train_timetables ] -= ::StationTrainTime.where(
        # arrival_station_id: ::Station.where( same_as: "odpt.Station:TokyoMetro.Fukutoshin.Wakoshi" ).pluck( :id )
      # ).pluck( :id )

      # puts h[ :station_train_times_from_train_timetables ].length

      # 和光市～氷川台発（副都心線）
      station_timetable_ids_of_fukutoshin_line_between_wakoshi_and_hikawadai = ::StationTimetable.where(
        station_id: ::Station.where( same_as: %W( Wakoshi ChikatetsuNarimasu ChikatetsuAkatsuka Heiwadai Hikawadai ).map { | station |
          "odpt.Station:TokyoMetro.Fukutoshin.#{station}"
        } )
      ).pluck( :id )

      h[ :station_train_times_from_train_timetables ] -= ::StationTrainTime.where(
        station_timetable_id: station_timetable_ids_of_fukutoshin_line_between_wakoshi_and_hikawadai
      ).pluck( :id )

      puts h[ :station_train_times_from_train_timetables ].length

      # 小竹向原発（副都心線 和光市方面）
      station_timetable_id_of_kotakemukaihara_on_fukutoshin_line_for_wakoshi = ::StationTimetable.find_by(
        same_as: "odpt.StationTimetable:TokyoMetro.Fukutoshin.KotakeMukaihara.Wakoshi"
      ).id

      h[ :station_train_times_from_train_timetables ] -= ::StationTrainTime.where(
        station_timetable_id: station_timetable_id_of_kotakemukaihara_on_fukutoshin_line_for_wakoshi
      ).pluck( :id )

      puts h[ :station_train_times_from_train_timetables ].length

      h[ :station_train_times_from_train_timetables ] = h[ :station_train_times_from_train_timetables ].sort
    end