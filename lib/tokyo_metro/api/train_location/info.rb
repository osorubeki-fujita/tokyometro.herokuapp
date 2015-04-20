# 個別の列車のロケーション情報を扱うクラス
class TokyoMetro::Api::TrainLocation::Info < TokyoMetro::Api::MetaClass::RealTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::TrainLocation

  include ::TokyoMetro::Modules::Api::Info::ToStringGeneral

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase
  include ::TokyoMetro::Modules::Common::Info::Decision::ToeiMitaLine
  include ::TokyoMetro::Modules::Common::Info::Decision::RomanceCar

  include ::TokyoMetro::Modules::Api::Info::Decision::RailwayLine
  include ::TokyoMetro::Modules::Api::Info::Decision::TrainType
  include ::TokyoMetro::Modules::Api::Info::Decision::TrainDirection
  include ::TokyoMetro::Modules::Api::Info::Decision::StartingStation
  include ::TokyoMetro::Modules::Api::Info::Decision::TerminalStation
  include ::TokyoMetro::Modules::Api::Info::Decision::OperatedSection

  # Constructor
  def initialize( id_urn , same_as , train_number , train_type , dc_date , valid , frequency ,
    railway_line , train_owner , railway_direction , delay , starting_station , terminal_station , from_station , to_station )
    @id_urn = id_urn
    @same_as = same_as
    @dc_date , @valid , @frequency = dc_date , valid , frequency
    @train_number , @train_type = train_number , train_type
    @railway_line , @train_owner , @railway_direction = railway_line , train_owner , railway_direction
    @delay = delay
    @starting_station , @terminal_station = starting_station , terminal_station
    @from_station , @to_station = from_station , to_station
  end

  # @!group 列車ロケーション情報のメタデータ (For developers)

  # 固有識別子 - URL
  # @return [String]
  # @note API での命名ルールは「odpt.Train:TokyoMetro.路線名.列車番号」
  attr_reader :same_as

  # データ生成時刻 - xsd:dateTime（ISO8601 日付時刻形式をもとに生成した DateTime のインスタンス）
  # @return [DateTime]
  # @example
  #  2013–01–13T15:10:00+09:00
  attr_reader :dc_date

  # データ保証期限 - xsd:dateTime（ISO8601 日付時刻形式をもとに生成した DateTime のインスタンス）
  # @return [DateTime]
  # @example
  #  2013–01–13T15:10:00+09:00
  attr_reader :valid

  # 更新頻度（秒） - xsd:integer
  # @return [Integer]
  # @note 指定された秒数以降にリクエストを行うことで、最新値が取得される。
  attr_reader :frequency

  # @!group 列車情報 (For users)

  # 列車番号 - xsd:string
  # @return [String]
  attr_reader :train_number

  # 列車種別 - odpt:TrainType
  # @return [String]
  # @note 各停 (odpt.TrainType:Local) 、急行 (odpt.TrainType:Express) 、快速 (odpt.TrainType:Rapid) 、特急 (odpt.TrainType:LimitedExpress) など
  attr_reader :train_type

  # 鉄道路線ID - odpt:Railway
  # @return [String]
  attr_reader :railway_line

  # 車両の所属会社 - odpt:TrainOwner
  # @return [String]
  attr_reader :train_owner

  # 列車の始発駅 - odpt:Station
  # @return [String]
  attr_reader :starting_station

  # 列車の終着駅 - odpt:Station
  # @return [String]
  attr_reader :terminal_station

  # 方面 - odpt:RailDirection
  # @return [String]
  # @example
  #  odpt.RailDirection:TokyoMetro.Shibuya - 渋谷方面行きを表す
  attr_reader :railway_direction

  # @!group 遅延 (For users)

  # 遅延時間（秒） - xsd:integer
  # @return [Integer]
  # @note 5分未満は切り捨て
  attr_reader :delay

  # @!group 列車ロケーション情報 (For users)

  # 列車が出発した駅 - odpt:Station
  # @return [String]
  attr_reader :from_station

  # 列車が向かっている駅 - odpt:Station
  # @return [String]
  # @return [nil] 列車が駅に停車している場合は nil
  attr_reader :to_station

  # @!endgroup

  def decorate( request , railway_line )
    ::TokyoMetro::Api::TrainLocation::Info::Decorator.new( request , self , railway_line )
  end

  def railway_direction_in_api_same_as
    railway_direction
  end

  # 定義されるメソッド
  #
  # to , to_sta
  # from , from_sta
  # starting , starting_sta
  # terminal , terminal_sta
  #
  [ :to , :from , :starting , :terminal ].each do | prefix |
    eval <<-ALIAS
      alias :#{prefix} :#{prefix}_station
      alias :#{prefix}_sta :#{prefix}_station
    ALIAS
  end

  alias :to_strf :to_s

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new

    set_data_to_hash( h , "\@id" , @id_urn )
    set_data_to_hash( h , "owl:sameAs" , @same_as )

    set_data_to_hash( h , "dc:date" , @dc_date.to_s )
    set_data_to_hash( h , "dct:valid" , @valid.to_s )
    set_data_to_hash( h , "odpt:frequency" , @frequency )

    set_data_to_hash( h , "odpt:railway" , @railway_line )
    set_data_to_hash( h , "odpt:railDirection" , @railway_direction )
    set_data_to_hash( h , "odpt:trainNumber" , @train_number )
    set_data_to_hash( h , "odpt:trainType" , @train_type )
    set_data_to_hash( h , "odpt.trainOwner" , @train_owner )

    set_data_to_hash( h , "odpt:startingStation" , @starting_sta )
    set_data_to_hash( h , "odpt:terminalStation" , @terminal_sta )

    set_data_to_hash( h , "odpt:delay" , @delay )

    set_data_to_hash( h , "odpt:fromStation" , @from_station )
    set_data_to_hash( h , "odpt:toStation" , @to_station )

    h
  end

  # @!group 遅延情報に関するメソッド (For users)

  def actual_delay
    @delay
  end

  def on_schedule?
    actual_delay == 0
  end

  # 遅延しているか否かを判定するメソッド
  # @param delay_minimum_second [Integer] 遅延とみなさない最大の秒数（遅延となる最小の秒数）
  # @return [Boolean]
  def delay_now?( delay_minimum_second )
    raise "Error" unless delay_minimum_second >= 0
    actual_delay > delay_minimum_second
  end

  # @!group 列車の現在位置に関するメソッド (For users)

  # 列車が駅に停車中か否かの真偽値（駅に停車中の場合は true ）
  # @return [Boolean]
  def now_at_station?
    @to_station.nil?
  end

  # 列車が駅間にいるか否かの真偽値（駅間にいる場合は true ）
  # @return [Boolean]
  def between_station?
    !( now_at_station? )
  end

  def delay_instance
    ::TokyoMetro::Api::TrainLocation::Info::Delay.new( actual_delay )
  end

=begin
  # 列車の現在位置
  # @return [StationInfo] 列車が駅に停車中の場合
  # @return [SectionInfo] 列車が駅間にいる場合
  def now_at
    if self.between_station?
      BetweenStation.new( @from_station , @to_station )
    else
      # ::TokyoMetro::Station...
    end
  end
=end

  # @!endgroup

end