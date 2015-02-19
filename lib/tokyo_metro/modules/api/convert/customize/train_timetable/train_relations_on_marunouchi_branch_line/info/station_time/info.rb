module TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine::Info::StationTime::Info

  def initialize( arrival_time , arrival_station , departure_time , departure_station , previous_trains = nil , following_trains = nil )
    super( arrival_time , arrival_station , departure_time , departure_station )
    @previous_trains = previous_trains
    @following_trains = following_trains
  end

  attr_reader :previous_trains
  attr_reader :following_trains

  #-------- 定義されるメソッド
  #
  # has_previous_trains?
  # has_following_trains?
  # previous_train_list
  # following_train_list
  # previous_trains_in_api
  # following_trains_in_api
  #
  [ :previous_trains , :following_trains ].each do | instance_variable_name |
    eval <<-DEF
      def has_#{ instance_variable_name }?
        @#{ instance_variable_name }.present?
      end

      def #{ instance_variable_name.to_s.singularize }_list
        if has_#{ instance_variable_name }?
          @#{ instance_variable_name }.list
        else
          ::Array.new
        end
      end

      def #{ instance_variable_name }_in_api
        if has_#{ instance_variable_name }?
          @#{ instance_variable_name }.trains_in_api
        else
          ::Array.new
        end
      end
    DEF
  end

  def has_train_relations?
    has_previous_trains? or has_following_trains?
  end

  #-------- 定義されるメソッド
  #
  # actual_starting_stations
  # actual_terminal_stations
  #
  [
    [ :starting , :previous ] ,
    [ :terminal , :following ]
  ].each do | starting_or_terminal , previous_or_following |
    eval <<-DEF

      def actual_#{ starting_or_terminal }_stations
        if has_#{ previous_or_following }_trains?
          @#{ previous_or_following }_trains.actual_#{ starting_or_terminal }_stations
        else
          ::Array.new
        end
      end

    DEF
  end

  def seed_train_relations( *args )
    [ @previous_trains , @following_trains ].each do | train_relations |
      train_relations.try( :seed , *args )
    end
    return nil
  end

end