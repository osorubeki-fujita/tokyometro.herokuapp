# 個別の列車時刻表のクラス
class TokyoMetro::Api::TrainTimetable::Info < TokyoMetro::Api::MetaClass::NotRealTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable  
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase

  include ::TokyoMetro::Modules::Common::Info::Decision::RomanceCar
  include ::TokyoMetro::Modules::Common::Info::Decision::ToeiMitaLine
  include ::TokyoMetro::Modules::Common::Info::Decision::SameAs

  include ::TokyoMetro::Modules::Api::Info::Decision::StartingStation
  include ::TokyoMetro::Modules::Api::Info::Decision::TerminalStation

  include ::TokyoMetro::Modules::Api::Info::Decision::RailwayLine
  include ::TokyoMetro::Modules::Api::Info::Decision::TrainType
  include ::TokyoMetro::Modules::Api::Info::Decision::OperatedSection
  include ::TokyoMetro::Modules::Api::Info::Decision::TrainDirection
  include ::TokyoMetro::Modules::Api::Info::Decision::TrainOperationDay

  # Constructor
  def initialize( id_urn , same_as , dc_date , train_number , railway_line , train_name , operator ,
  train_type , railway_direction , starting_station , terminal_station , train_owner ,
  weekdays , saturdays , holidays )
    @id_urn = id_urn
    @same_as = same_as
    @dc_date = dc_date
    @train_number = train_number
    @railway_line = railway_line
    @train_name = train_name
    @operator = operator
    @train_type = train_type
    @railway_direction = railway_direction

    @starting_station = starting_station
    @terminal_station = terminal_station
    @train_owner = train_owner

    @weekdays = weekdays
    @saturdays = saturdays
    @holidays = holidays
  end

  # @!group 列車時刻表のメタデータ (For developers)

  # 固有識別子 - URL
  # @return [String]
  # @note 命名ルールは「odpt.TrainTimetable:TokyoMetro.路線名.列車番号（.曜日 ？）」
  attr_reader :same_as

  # データ生成時刻（ISO8601 日付時刻形式） - xsd:dateTime
  # @return [DateTime]
  # @example
  #  2013–01–13T15:10:00+09:00
  attr_reader :dc_date

  # @!group 列車のデータ (For users)

  # 列車番号
  # @return [String]
  attr_reader :train_number

  # 路線 - odpt:Railway
  # @return [String]
  attr_reader :railway_line

  attr_reader :train_name

  # 運行会社 - odpt:Operator
  # @return [String]
  attr_reader :operator

  attr_reader :train_type

  # 方面 - odpt:RailDirection
  # @return [String]
  attr_reader :railway_direction

  # 列車の始発駅 - odpt:Station
  # @return [String or nil]
  # @note 他社線始発の場合のみ格納
  attr_reader :starting_station

  # 列車の終着駅 - odpt:Station
  # @return [String]
  attr_reader :terminal_station

  # 車両の所属会社 - odpt:TrainOwner
  # @return [String]
  # @note 判明する場合のみ格納
  attr_reader :train_owner

  # @!group 列車の各駅の発着時刻のデータ

  # 平日の列車時刻
  # @return [TokyoMetro::Api::TrainTimetable::Info::StationTime::List]
  # @note 出発時間と出発駅の組か、到着時間と到着駅の組のリストを格納
  attr_reader :weekdays

  # 土曜日の列車時刻
  # @return [TokyoMetro::Api::TrainTimetable::Info::StationTime::List]
  # @note 出発時間と出発駅の組か、到着時間と到着駅の組のリストを格納
  attr_reader :saturdays

  # 休日の列車時刻
  # @return [TokyoMetro::Api::TrainTimetable::Info::StationTime::List]
  # @note 出発時間と出発駅の組か、到着時間と到着駅の組のリストを格納
  attr_reader :holidays

  # @!group 列車のデータ（追加）

  # 車両数
  attr_reader :car_composition

  attr_reader :previous_train
  attr_reader :following_train

  # @!endgroup

  def set_car_number( car_composition )
    @car_composition = car_composition
  end

  def instance_in_db
    ::TrainTimetable.find_by_same_as( @same_as )
  end

  # @!group 列車時刻

  def timetables
    [ @weekdays , @saturdays , @holidays ]
  end

  # 運行日の列車時刻
  # @return [::TokyoMetro::Api::TrainTimetable::Info::StationTime::List <::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info>]
  # @note 平日運行の場合は @weekdays , 土休日運行の場合は @holidays を返す。
  def valid_list
    if operated_on_weekdays?
      @weekdays
    elsif operated_on_saturdays_and_holidays?
      @holidays
    end
  end

  # @!endgroup

  # @!group 停車駅に関するメソッド

  def stops_at?( station_same_as )
    valid_list.stops_at?( station_same_as )
  end

  alias :stop_at? :stops_at?
  alias :goes_to? :stops_at?
  alias :go_to? :stops_at?

  def stops_at_both?( *stations_same_as )
    stations_same_as.flatten.all?( &proc_for_deciding_whether_stops_or_not )
  end

  def stops_at_either?( *stations_same_as )
    stations_same_as.flatten.any?( &proc_for_deciding_whether_stops_or_not )
  end

  # @!endgroup

  [ :station_time_info_of , :index_of , :station_time_info_and_index_of ].each do | method_name |
    eval <<-DEF
      def #{ method_name }( station_same_as )
        valid_list.#{ method_name }( station_same_as )
      end
    DEF
  end

  def time_of( *stations_same_as )
    stations_same_as = stations_same_as.flatten
    ary_of_station_same_as = stations_same_as.select( &proc_for_deciding_whether_stops_or_not )

    case ary_of_station_same_as.length
    when 0
      nil
    when 1
      station_same_as = ary_of_station_same_as.first
      station_time_info_of( station_same_as ).time
    else
      error_msg_ary = ::Array.new
      error_msg_ary << "Error:"
      error_msg_ary += [
        "Train is same as ... #{ @same_as }" ,
        "Stations are same as ... #{ stations_same_as.to_s }" ,
        "Considered stations ... #{ ary_of_station_same_as.to_s }"
      ].map { | str | " " * 4 + str }

      error_msg_ary << " " * 4 + "Stations where this train stops ... "
      error_msg_ary += stations.map { | str | " " * 8 + str }
      raise error_msg_ary.join( "\n" )
    end
  end

  def stopping_stations
    valid_list.stopping_stations
  end

  def stations
    valid_list.stations
  end

  def number_of_station_times
    valid_list.length
  end

  private

  def proc_for_deciding_whether_stops_or_not
    ::Proc.new { | station_same_as | stops_at?( station_same_as ) }
  end

  # @!group DBへの流し込みに関するメソッド

  def seed_arrival_times_of_romance_car
    self.class.factory_for_seeding_each_arrival_time_of_romance_car.process( self )
  end

  def seed_arrival_time_of_last_station_in_tokyo_metro
    self.class.factory_for_seeding_each_arrival_time_of_last_station_in_tokyo_metro.process( self )
  end

end