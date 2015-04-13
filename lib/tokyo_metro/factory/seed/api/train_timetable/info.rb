class TokyoMetro::Factory::Seed::Api::TrainTimetable::Info < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable
  include ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Common

  include ::TokyoMetro::Factory::Seed::Reference::RailwayLine
  include ::TokyoMetro::Factory::Seed::Reference::Station
  include ::TokyoMetro::Factory::Seed::Reference::RailwayDirection
  include ::TokyoMetro::Factory::Seed::Reference::Operator
  include ::TokyoMetro::Factory::Seed::Reference::TrainOwner

  include ::TokyoMetro::Factory::Seed::Reference::DcDate
  include ::TokyoMetro::Factory::Seed::Reference::OperationDay
  include ::TokyoMetro::Factory::Seed::Reference::TrainType
  include ::TokyoMetro::Factory::Seed::Reference::TrainName

  def self.train_type_factory
    ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::TrainType
  end

  private

  # [Update で追加]
  #   car_composition
  #   train_timetable_arrival_info_id
  #   train_timetable_connection_info_id
  #   train_timetable_train_type_in_other_operator_id
  def hash_to_db
    h = ::Hash.new

    _railway_line_in_db = railway_line_in_db( @railway_lines )
    _starting_station_in_db = starting_station_in_db
    _terminal_station_in_db = terminal_station_in_db
    _operation_day_in_db = operation_day_in_db

    h[ :railway_line_id ] = _railway_line_in_db.id
    h[ :starting_station_id ] = _starting_station_in_db.id
    h[ :terminal_station_id ] = _terminal_station_in_db.id
    h[ :operation_day_id ] = _operation_day_in_db.id

    h[ :railway_direction_id ] = railway_direction_id( _railway_line_in_db.id )

    h[ :train_type_id ] = train_type_id( _railway_line_in_db , _starting_station_in_db , _terminal_station_in_db , _operation_day_in_db )

    [ :id_urn , :same_as , :train_number ].each do | column_name |
      h[ column_name ] = @info.send( column_name )
    end

    [ :dc_date , :operator_id , :train_owner_id , :train_name_id ].each do | column_name |
      h[ column_name ] = self.send( column_name )
    end

    h
  end

  def operator_id
    super( @operators )
  end

  def starting_station_in_db
    station_in_db( @stations , search_by: @info.starting_station )
  end

  def starting_station_id
    station_id( @stations , search_by: @info.starting_station )
  end

  def terminal_station_in_db
    station_in_db( @stations , search_by: @info.terminal_station )
  end

  def terminal_station_id
    station_id( @stations , search_by: @info.terminal_station )
  end

  def railway_direction_id( _railway_line_id )
    super( _railway_line_id , @railway_directions )
  end

  def train_owner_id
    super( @train_owners )
  end

  def operation_day_id
    super( operation_day_name_en )
  end

  def operation_day_in_db
    ::OperationDay.find( operation_day_id )
  end

  def operation_day_name_en
    if @info.operated_on_weekdays?
      ::TokyoMetro::Static.operation_days.weekday.en
    elsif @info.operated_on_saturdays_and_holidays?
      ::TokyoMetro::Static.operation_days.saturday_and_holiday.en
    else
      raise "Error: \"#{ @info.same_as }\" is not valid."
    end
  end

end