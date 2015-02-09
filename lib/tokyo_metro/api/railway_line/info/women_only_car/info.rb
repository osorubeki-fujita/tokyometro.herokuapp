# 個々の女性専用車両の情報を扱うクラス
class TokyoMetro::Api::RailwayLine::Info::WomenOnlyCar::Info < TokyoMetro::Api::RailwayLine::Info::MetaClass::Info

  # Constructor
  def initialize( from_station , to_station , operation_day , available_time_from , available_time_until , car_composition , car_number )
    raise "Error" unless available_time_from.instance_of?( ::Time )
    raise "Error" unless available_time_until.instance_of?( ::Time )
    @from_station = from_station
    @to_station = to_station
    @operation_day = operation_day
    @available_time_from = available_time_from
    @available_time_until = available_time_until
    @car_composition = car_composition
    @car_number = car_number
  end

  # 開始駅 <odpt:fromStation - odpt:Station>
  # @return [String]
  attr_reader :from_station

  # 終了駅 <odpt:toStation - odpt:Station>
  # @return [String]
  attr_reader :to_station

  # 実施曜日 <odpt:operationDay - xsd:string>
  # @return [String]
  attr_reader :operation_day

  # 開始時間 <odpt:availableTimeFrom - odpt:Time>
  # @return [Time]
  attr_reader :available_time_from

  # 終了時間 <odpt:availableTimeUntil - odpt:Time>
  # @return [Time]
  attr_reader :available_time_until

  # 車両編成数 <odpt:carComposition - xsd:integer>
  # @return [Integer]
  attr_reader :car_composition

  # 実施車両 号車番号 <odpt:carNumber - Array (xsd:integer)>
  # @return [::Array <Integer>]
  attr_reader :car_number

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new
    set_data_to_hash( h , "odpt:fromStation" , @from_station )
    set_data_to_hash( h , "odpt:toStation" , @to_station )
    set_data_to_hash( h , "odpt:operationDay" , @operation_day )
    set_data_to_hash( h , "odpt:availableTimeFrom" , @available_time_from )
    set_data_to_hash( h , "odpt:availableTimeUntil" , @available_time_until )
    set_data_to_hash( h , "odpt:carComposition" , @car_composition )
    set_data_to_hash( h , "odpt:carNumber" , @car_number )
    h
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    to_s_with_array( [] , indent )
  end

  alias :to_strf :to_s

  def self.factory_for_generating_from_hash
    factory_for_generating_women_only_car_info_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_women_only_car_infos
  end

end