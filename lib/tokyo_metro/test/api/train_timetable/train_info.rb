class TokyoMetro::Test::Api::TrainTimetable::TrainInfo

  def initialize( train )
    @train_number = train.train_number
    @railway_direction = train.railway_direction
    @starting_station = train.starting_station
    @terminal_station = train.terminal_station
    @first_station_of_station_time_infos = train.valid_array.first.station
    @last_station_of_station_time_infos = train.valid_array.last.station
  end

  attr_reader :train_number , :railway_direction , :starting_station , :terminal_station , :first_station_of_station_time_infos , :last_station_of_station_time_infos

  def <=>( other )
    array_of_methods = [ :railway_direction , :starting_station , :terminal_station , :first_station_of_station_time_infos , :last_station_of_station_time_infos ]
    evaluated_string = array_of_methods.map { | method_name |
      "compare_sub( #{method_name} , other )"
    }.join( " do ; " ) + " ; end" * ( array_of_methods.length - 1 )

    eval( evaluated_string )
  end

  def to_a
    [ @train_number ] + to_a_without_train_number
  end

  def to_s
    to_a.join( "\n" )
  end

  def to_a_without_train_number
    [ @railway_direction , @starting_station , @terminal_station , @first_station_of_station_time_infos , @last_station_of_station_time_infos ]
  end

  def to_s_without_train_number
    to_a_without_train_number.join( "\n" )
  end

  def output
    arr = [
      [ "Starting station" , station_name_in_db( @starting_station ) ] ,
      [ "First station of station time infos" , station_name_in_db( @first_station_of_station_time_infos ) ] ,
      [ "Last station of station time infos" , station_name_in_db( @last_station_of_station_time_infos ) ] ,
      [ "Terminal station" , station_name_in_db( @terminal_station ) ] ,
      [ "Railway direction" , @railway_direction ]
    ]
=begin
    arr.each_with_index.map { | element , i |
      title , var = element
      str = title.ljust(48) + " : " + var
      if i == 0
        "○ #{str}"
      else
        " " * 3 + str
      end
    }.join( "\n" )
=end
    arr.map { | element | element.join( ":" ) }.join( "\n" )
  end

  private

  def compare_sub( method_name , other )
    case self.send( method_name ) <=> other.send( method_name )
    when 1
      return 1
    when -1
      return -1
    else
      if block_given?
        yield
      else
        0
      end
    end
  end

  def station_name_in_db( station_name_same_as )
    station_in_db = ::STATIONS.find_by_same_as( station_name_same_as )
    station_in_db.name_ja + "（" + station_in_db.railway_line.name_ja_with_operator_name + "）"
  end

end