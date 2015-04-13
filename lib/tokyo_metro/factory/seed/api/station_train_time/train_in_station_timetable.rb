class TokyoMetro::Factory::Seed::Api::StationTrainTime::TrainInStationTimetable

  # Constructor
  # @param station_timetable_info [::TokyoMetro::Factory::Seed::Api::StationTrainTime::TrainInStationTimetable::StationTimetableInfo]
  # @param train [::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info]
  def initialize( train , station_timetable_info , operation_day_in_db , train_timetables )
    @train = train
    @station_timetable_info = station_timetable_info

    class << @train
      include ::TokyoMetro::Refinement::Api::StationTimetable::Info::TrainTime::Info::TerminalStationsSameAs
    end

    @operation_day_in_db = operation_day_in_db
    @train_timetables = train_timetables
  end

  # @return [::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info]
  attr_reader :train

  # @return [::TokyoMetro::Factory::Seed::Api::StationTrainTime::TrainInStationTimetable::StationTimetableInfo]
  attr_reader :station_timetable_info
  attr_reader :train_timetables
  attr_reader :operation_day_in_db

  def self.find_and_get_train_timetable_infos_of_this_train( train , station_timetable_info , operation_day_in_db , train_timetables )
    self.new( train , station_timetable_info , operation_day_in_db , train_timetables ).find_and_get_train_timetable_infos_of_this_train
  end

  def find_and_get_train_timetable_infos_of_this_train
    @train_timetable_in_api = train_timetable_in_api
    @instance_of_actual_departure_station_in_db = instance_of_actual_departure_station_in_db

    h = ::Hash.new

    [ :station_timetable_in_db , :train_timetable_in_db , :station_set_in_db ].each do | key_name |
      h[ key_name ] = self.send( key_name )
    end

    h.merge( @train_timetable_in_api.station_time_info_and_index_of( @instance_of_actual_departure_station_in_db.same_as ) )
  end

  private

  def train_timetable_in_api
    t = @train_timetables.find { | train_timetable |
      class << train_timetable
        include ::TokyoMetro::Refinement::Api::TrainTimetable::Info::Match
      end
      train_timetable.matches_station_timetable?( @train , @station_timetable_info , @operation_day_in_db )
    }

    unless t.present?
      raise error_msg_of_finding_train_timetable_in_api
    end

    t
  end

  # @note {::TokyoMetro::Factory::Seed::Api::StationTrainTime::TrainInStationTimetable::StationTimetableInfo} のメソッド
  [ :railway_lines , :railway_lines_same_as , :railway_lines_to_s , :stations , :stations_same_as , :stations_to_s , :station_timetable_in_db ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        @station_timetable_info.#{ method_name }
      end
    DEF
  end

  # @note {::TokyoMetro::Refinement::Api::StationTimetable::Info::TrainTime::Info::TerminalStationsSameAs.terminal_stations_same_as} を呼び出す。
  def terminal_stations_same_as
    @train.send( :terminal_stations_same_as , railway_lines )
  end

  def terminal_stations_to_s
    terminal_stations_same_as.join( " / " )
  end

  def error_msg_of_finding_train_timetable_in_api
    error_message_ary = ::Array.new
    error_message_ary << "\n"
    error_message_ary << "Error: The train timetable including these informations does not exist."
    [
      [ "Depart from" , stations_to_s + " (#{ railway_lines_to_s })" ] ,
      [ "Departure time" , @train.departure_time_array.join( ":" ) ] ,
      [ "Terminal station" , terminal_stations_to_s ] ,
      [ "Operation day" , @operation_day_in_db.name_en ]
    ].each do | title , info |
      error_message_ary << ( title.ljust(24) + " ... " + info )
    end
    error_message_ary.join( "\n" )
  end

  def train_timetable_in_db
    ::TrainTimetable.find_by_same_as( @train_timetable_in_api.same_as )
  end

  def instance_of_actual_departure_station_in_db
    @station_timetable_info.instance_of_actual_station_in_api( @train_timetable_in_api )
  end

  def station_set_in_db
    { departure: @instance_of_actual_departure_station_in_db }
  end

end