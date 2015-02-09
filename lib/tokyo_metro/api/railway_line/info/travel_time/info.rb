# 各駅間の標準所要時間を扱うクラス
class TokyoMetro::Api::RailwayLine::Info::TravelTime::Info < TokyoMetro::Api::RailwayLine::Info::MetaClass::Info

  # Constructor
  def initialize( from_station , to_station , necessary_time )
    @from_station = from_station
    @to_station = to_station
    @necessary_time = necessary_time
  end

  # 駅間の起点 <odpt:fromStation - odpt:Station>
  # @return [String]
  attr_reader :from_station
  alias :from :from_station

  # 駅間の終点 <odpt:toStation - odpt:Station>
  # @return [String]
  attr_reader :to_station
  alias :to :to_station

  # 駅間の所要時間（分） <odpt:necessaryTime - xsd:integer>
  # @return [Integer]
  attr_reader :necessary_time
  alias :time :necessary_time

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    str_ary = ::Array.new
    self.to_h.each do | key , value |
      str_ary << " " * indent + key.ljust(32) + value.to_s
    end
    str_ary.join( "\n" )
  end

  alias :to_strf :to_s

  def to_a
    [ @from_station , @to_station , @necessary_time ]
  end

  def to_h
    h = Hash.new
    h[ "odpt:fromStation" ] = @from_station
    h[ "odpt:toStation" ] = @to_station
    h[ "odpt:necessaryTime" ] = @necessary_time
    h
  end

  def between?( station_a , station_b )
    [ @from_station , @to_station ] == [ station_a , station_b ] or [ @from_station , @to_station ] == [ station_b , station_a ]
  end

  def self.factory_for_generating_from_hash
    factory_for_generating_travel_time_info_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_travel_time_infos
  end

end