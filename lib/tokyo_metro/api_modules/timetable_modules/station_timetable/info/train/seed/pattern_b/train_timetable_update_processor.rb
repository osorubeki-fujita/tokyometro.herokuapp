class TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternB::TrainTimetableUpdateProcessor

  def initialize( train , station_timetable , train_timetable )
    @train = train
    @station_timetable = station_timetable
    @train_timetable = train_timetable
    @hash = ::Hash.new
  end

  def process
    get_car_composition
    get_timetable_arrival_info
    get_timetable_connection_info
    get_timetable_train_type_in_other_operator
    update_train_timetable
  end

  def self.process( train , station_timetable , train_timetable )
    self.new( train , station_timetable , train_timetable ).process
  end

  private

  def get_car_composition
    get_optional_info( :car_composition , :car_composition , "Car composition" , false )
  end

  def get_timetable_arrival_info
    get_optional_info( :timetable_arrival_info_id_in_db , :timetable_arrival_info_id , "Arrival info" )
  end

  def get_timetable_connection_info
    get_optional_info( :timetable_connection_info_id_in_db , :timetable_connection_info_id , "Connection info" )
  end

  def get_timetable_train_type_in_other_operator
    get_optional_info( :timetable_train_type_in_other_operator_id_in_db , :timetable_train_type_in_other_operator_id , "Train type in other operator" , false )
  end

  def get_optional_info( method_for_train , method_for_train_timetable , title , require_railway_instance = true )
    methods_send_to_train = [ method_for_train ]
    if require_railway_instance
      methods_send_to_train += [ @station_timetable.railway_line ]
    end
    info = @train.send( *methods_send_to_train )
    if info.present?
      info_in_train_timetable = @train_timetable.send( method_for_train_timetable )
      if info_in_train_timetable.nil?
        @hash[ method_for_train_timetable ] = info
      elsif info_in_train_timetable != info
        seed__update_optional_info__raise_error( train_timetable_instance , title )
      end
    end
  end

  def seed__update_optional_info__raise_error( train_timetable_instance , title )
    raise "Error: #{title} is not valid. (#{train_timetable_instance.same_as})"
  end

  def update_train_timetable
    @train_timetable.update( @hash )
  end

end