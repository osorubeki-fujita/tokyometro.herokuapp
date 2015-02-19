# @note {TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine#.set_modules} により {::TokyoMetro::Api::TrainTimetable::Info} へ prepend される。
module TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine::Info

  # Constructor
  def initialize( *variables )
    super( *variables )
    if marunouchi_line_including_branch?
      convert_starting_and_terminal_station_of_trains_between_nakano_fujimico_and_ogikubo
      set_train_relations_on_marunouchi_branch_line
    end
  end

  # @!group Class Methods

  def self.marunouchi_branch_line_dictionary_namespace
    ::TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine::Dictionary
  end

  # @!group Instance Methods

  #-------- 定義されるメソッド
  #
  # has_previous_trains?
  # has_following_trains?
  # has_train_relations?
  #
  [ :has_previous_trains? , :has_following_trains? , :has_train_relations? ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        self.valid_list.send( method_name )
      end
    DEF
  end

  #-------- 定義されるメソッド
  #
  # previous_train_list
  # following_train_list
  # previous_trains_in_api
  # following_trains_in_api
  #
  [ :previous_trains , :following_trains ].each do | method_base_name |
    [ "#{ method_base_name.to_s.singularize }_list" , "#{ method_base_name }_in_api" ].each do | method_name |
      eval <<-DEF

        def #{ method_name }
          self.valid_list.#{ method_name }
        end

      DEF
    end
  end

  #-------- 定義されるメソッド
  #
  # actual_starting_stations
  # actual_terminal_stations
  #
  [ :starting_station , :terminal_station ].each do | method_base_name |
    defined_method_name = "actual_#{ method_base_name }s"
    eval <<-DEF

      def #{ defined_method_name }
        ary = self.valid_list.#{ defined_method_name }
        if ary.present?
          ary
        else
          [ @#{ method_base_name } ]
        end
      end

    DEF
  end

  # @!group Seed Train Relations

  # @note 東京メトロ Open Data では、データ構造上使用しない。
  def seed_train_relations( *args )
    self.valid_list.send( __method__ , *args )
  end

  # @!endgroup

  private

  # @!group Set starting and terminal station names

  def convert_starting_and_terminal_station_of_trains_between_nakano_fujimico_and_ogikubo
    _info_of_stations_in_dictionary = info_of_stations_in_dictionary
    if _info_of_stations_in_dictionary.present?
      @starting_station = _info_of_stations_in_dictionary[ "starting_station" ]
      @terminal_station = _info_of_stations_in_dictionary[ "terminal_station" ]
    end
  end

  def info_of_stations_in_dictionary
    self.class.starting_and_terminal_stations_of_marunouchi_branch_line_train.find { | item | item[ "trains" ].include?( @same_as ) }
  end

  # @!group Set train relations

  def set_train_relations_on_marunouchi_branch_line
    set_previous_train_on_marunouchi_branch_line
    set_following_train_on_marunouchi_branch_line
  end

  #-------- 定義されるメソッド
  #
  # set_previous_train_on_marunouchi_branch_line
  # set_following_train_on_marunouchi_branch_line
  #
  [
    [ :previous , :first , :departure , :starting ] ,
    [ :following , :last , :arrival , :terminal ]
  ].each do | previous_or_following , first_or_last , departure_or_arrival , starting_or_terminal |
    eval <<-DEF

      def set_#{ previous_or_following }_train_on_marunouchi_branch_line
        _#{ previous_or_following }_train = #{ previous_or_following }_train_in_dictionary
        if _#{ previous_or_following }_train.present?
          #{ first_or_last }_station_time_of_this_train = valid_list.#{ first_or_last }

          unless #{ first_or_last }_station_time_of_this_train.#{ departure_or_arrival }_station == @#{ starting_or_terminal}_station
            raise "Error"
          end

          #{ first_or_last }_station_time_of_this_train.instance_eval do
            @#{ previous_or_following }_trains = self.class.#{ previous_or_following }_train_list_class.new( [
              self.class.#{ previous_or_following }_train_info_class.new( _#{ previous_or_following }_train )
            ] ) 
          end
        end
      end

    DEF
  end

  #-------- 定義されるメソッド
  #
  # previous_train_in_dictionary
  # following_train_in_dictionary
  #
  [
    [ :previous , :- , 0 ] ,
    [ :following , :+ , "train_relations.length - 1" ]
  ].each do | previous_or_following , plus_or_minus , exception_of_position |
    eval <<-DEF

      def #{ previous_or_following }_train_in_dictionary
        train_relations = train_relations_of_this_train_in_dictionary

        if train_relations.present?
          index_of_this_train = train_relations.index( @same_as )
          unless index_of_this_train == #{ exception_of_position }
            return train_relations[ index_of_this_train #{ plus_or_minus } 1 ]
          end
        end

        return nil
      end

    DEF
  end

  def train_relations_of_this_train_in_dictionary
    self.class.train_relations_on_marunouchi_branch_line.find { | item | item.include?( @same_as ) }
  end

  # @!endgroup

end