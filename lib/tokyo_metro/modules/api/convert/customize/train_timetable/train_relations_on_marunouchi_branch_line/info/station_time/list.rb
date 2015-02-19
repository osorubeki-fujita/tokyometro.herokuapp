module TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine::Info::StationTime::List

  #-------- 定義されるメソッド
  #
  # has_previous_trains?
  # has_following_trains?
  # has_train_relations?
  #
  [ :has_previous_trains? , :has_following_trains? , :has_train_relations? ].each do | method_name |
    eval <<-DEF

      def #{ method_name }
        self.any?( &:#{ method_name } )
      end

    DEF
  end

  #-------- 定義されるメソッド
  #
  # previous_train_list
  # previous_trains_in_api
  # following_train_list
  # following_trains_in_api
  #
  # actual_starting_stations
  # actual_terminal_stations
  #
  defined_methods = [ :previous_trains , :following_trains ].map { | method_base_name |
    [ "#{ method_base_name.to_s.singularize }_list" , "#{ method_base_name }_in_api" ]
  }.flatten + [ :actual_starting_stations , :actual_terminal_stations ]

  defined_methods.each do | defined_method |
    eval <<-DEF

      def #{ defined_method }
        self.map( &:#{ defined_method } ).flatten
      end

    DEF
  end

  # @note 東京メトロ Open Data では、データ構造上使用しない。
  def seed_train_relations( *args )
    self.each do | station_time |
      station_time.send( __method__ , *args )
    end
  end

end