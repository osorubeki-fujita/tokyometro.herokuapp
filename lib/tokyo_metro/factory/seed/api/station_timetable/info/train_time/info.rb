class TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::Info < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable
  include ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::Common

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase
  include ::TokyoMetro::Modules::Common::Info::Decision::CurrentStation
  include ::TokyoMetro::Modules::Common::Info::Decision::TrainType

  def initialize( *args )
    super( *args , get_id: true )
    class << @info
      include ::TokyoMetro::Refinement::Api::StationTimetable::Info::TrainTime::Info::OptionalInfoId
    end
  end

  def self.train_timetable_update_processor_class
    ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::Info::UpdateTrainTimetable
  end

  private

  def set_optional_variables( args )
    super( args )
    @train_timetable_info = ::TokyoMetro::Factory::Seed::Api::StationTrainTime::TrainInStationTimetable.find_and_get_train_timetable_infos_of_this_train( @info , *optional_variables )
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_station_train_time
  end

  def hash_to_db
    puts " " * 32 + "Train is same as: " + train_timetable_in_db.same_as
    puts " " * 32 + "Terminal station: " + train_timetable_in_db.terminal_station.same_as
    # puts "Train number: " + train_timetable_in_db.train_number
    # puts ""

    h = ::Hash.new

    h = h.merge( time_infos )

    [ :is_last , :is_origin , :platform_number ].each do | key_name |
      h[ key_name ] = @info.send( key_name )
    end

    [
      :station_timetable_id ,
      :train_timetable_id ,
      :departure_station_id ,
      :index_in_train_timetable ,
      :station_timetable_starting_station_info_id ,
      :train_type_in_this_station_id ,
      :station_timetable_connection_info_id # 接続情報は station_train_time に対して定義する。（train_timetable_connection_info_id でないことに注意）
    ].each do | key_name |
      h[ key_name ] = self.send( key_name )
    end

    h[ :stop_for_drivers ] = false

    h
  end

  def seed_optional_infos
    update_train_timetable!
    seed_train_relations

    train_time_in_station_timetable_seed_completed!
    station_time_in_train_timetable_seed_completed!
  end

  def update_train_timetable!
    self.class.train_timetable_update_processor_class.process( @info , station_timetable_in_db , train_timetable_in_db )
  end

  def seed_train_relations
    station_time_in_train_timetable.seed_train_relations( @id , train_timetable_id )
  end

  def train_time_in_station_timetable_seed_completed!
    @info.seed_completed!
  end

  def station_time_in_train_timetable_seed_completed!
    station_time_in_train_timetable.seed_completed!
  end

  #-------- 定義されるメソッド
  #
  # station_timetable_in_db
  # station_time_in_train_timetable
  # train_timetable_in_db
  # index_in_train_timetable
  # station_set_in_db
  #
  [ :station_timetable_in_db , :station_time_in_train_timetable , :train_timetable_in_db , :index_in_train_timetable , :station_set_in_db ].each do | method_base_name |
    eval <<-DEF
      def #{method_base_name}
        @train_timetable_info[ :#{method_base_name} ]
      end
    DEF
  end

  def time_infos
    station_time_in_train_timetable.time_to_h
  end

  def departure_station_in_db
    station_set_in_db[ :departure ]
  end

  #-------- 定義されるメソッド
  #
  # station_timetable_id
  # train_timetable_id
  # departure_station_id
  #
  [ :station_timetable , :train_timetable , :departure_station ].each do | method_base_name |
    eval <<-DEF
      def #{method_base_name}_id
        #{method_base_name}_in_db.id
      end
    DEF
  end

  def departure_station_same_as
    departure_station_in_db.same_as
  end

  def train_type_in_this_station_id
    self.class.factory_for_train_type.id_in_db(
      actual_train_type ,
      train_timetable_in_db.railway_line ,
      train_timetable_in_db.terminal_station ,
      @operation_day_in_db ,
      station_timetable_in_db.stations
    )
  end

  def railway_line_ids
    station_timetable_in_db.railway_lines.pluck( :id )
  end

  [ :starting_station_info_id , :connection_info_id ].each do | method_base_name |
    eval <<-DEF
      def station_timetable_#{ method_base_name }
        @info.#{ method_base_name }( railway_line_ids )
      end
    DEF
  end

  def actual_train_type
    if at_namboku_and_toei_mita_line_common_station? and train_timetable_in_db.toei_mita_line?
      if local?
        "odpt.TrainType:Toei.Local"
      elsif express?
        "odpt.TrainType:Toei.Express"
      else
        raise "Error"
      end
    else
      @info.train_type
    end
  end

  def station_same_as__is_in?( *variables )
    super( *variables , departure_station_same_as )
  end

  def train_type_of?( *variables , compared )
    super( *variables , @info.train_type )
  end

  alias :is_train_type_of? :train_type_of?

end