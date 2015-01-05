# 各駅の情報を扱うクラス
class TokyoMetro::Api::RailwayLine::Info::StationOrder::Info

  include ::TokyoMetro::ApiModules::ToFactoryClass::GenerateFromHash

  # Constructor
  def initialize( index , station )
    @index = index
    @station = station
  end

  # 駅の順序 <odpt:index - xsd:integer>
  # @return [Integer]
  # @note 駅番号ではない。
  attr_reader :index

  # 駅名 <odpt:station - odpt:Station>
  # @return [String]
  attr_reader :station
  alias :name :station
  alias :station_name :station

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    " " * indent + "\[#{ self.index.to_s.rjust(4) }\] #{self.station}"
  end

  def to_h
    { "odpt:index" => @index , "odpt:station" => @station }
  end

=begin
  # @note 使用停止中
  def seed
    ::Station.find_by( same_as: @station ).update( index_in_railway_line: @index )
  end
=end

  alias :to_strf :to_s

  def self.factory_for_generating_from_hash
    ::TokyoMetro::Factories::Api::GenerateFromHash::RailwayLine::Info::StationOrder
  end

end