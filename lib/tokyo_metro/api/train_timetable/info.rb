# 個別の列車時刻表のクラス
class TokyoMetro::Api::TrainTimetable::Info < TokyoMetro::Api::MetaClass::NotRealTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  include ::TokyoMetro::ApiModules::Decision::StartingStation
  include ::TokyoMetro::ApiModules::Decision::TerminalStation

  include ::TokyoMetro::ApiModules::Decision::RailwayLine
  include ::TokyoMetro::ApiModules::Decision::TrainType
  include ::TokyoMetro::ApiModules::Decision::OperatedSection
  include ::TokyoMetro::ApiModules::Decision::TrainDirection
  include ::TokyoMetro::ApiModules::Decision::TrainOperationDay

  include ::TokyoMetro::CommonModules::Decision::RomanceCar

  # Constructor
  def initialize( id_urn , same_as , dc_date , train_number , railway_line , operator ,
  train_type , railway_direction , starting_station , terminal_station , train_owner ,
  weekdays , saturdays , holidays )
    @id_urn = id_urn
    @same_as = same_as
    @dc_date = dc_date
    @train_number = train_number
    @railway_line = railway_line
    @operator = operator
    @train_type = train_type
    @railway_direction = railway_direction

    @starting_station = starting_station
    @terminal_station = terminal_station
    @train_owner = train_owner

    @weekdays = weekdays
    @saturdays = saturdays
    @holidays = holidays

    if @starting_station.nil?
      @starting_station = valid_list.first.station
    end
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

  # @!endgroup

  def set_car_number( car_composition )
    @car_composition = car_composition
  end

  def instance_in_db
    ::TrainTimetable.find_by_same_as( @same_as )
  end

  # @!group 列車時刻

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

  # @!group 停車駅に関するメソッド

  def stops_at?( station_same_as )
    valid_list.any? { | station_time | station_time.station == station_same_as }
  end
  alias :stop_at? :stops_at?
  alias :goes_to? :stops_at?
  alias :go_to? :stops_at?
  
  # @!endgroup

  def info_of( station_same_as )
    valid_list.find { | station_time | station_time.station == station_same_as }
  end

  def time_of( station_same_as )
    if stops_at?( station_same_as )
      info_of( station_same_as ).time
    else
      nil
    end
  end

  def stopping_stations
    valid_list.stopping_stations
  end

end