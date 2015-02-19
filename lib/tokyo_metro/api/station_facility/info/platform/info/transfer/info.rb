# 乗り換えの情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::Platform::Info::Transfer::Info < TokyoMetro::Api::StationFacility::Info::Platform::Info::Common::Info

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase
  include ::TokyoMetro::Modules::Api::Info::Decision::RailwayLine

  # Constructor
  def initialize( railway_line , railway_direction , necessary_time )
    @railway_line = railway_line
    @railway_direction = railway_direction
    @necessary_time = necessary_time
  end

  # @return [String] 乗り換え可能路線（API でのクラスは odpt:Railway）
  attr_reader :railway_line
  # @return [String] 乗り換え可能路線の方面（乗り換え可能な方面を特記する必要がある場合にのみ記載）
  #  （API でのクラスは odpt:RailDirection）
  # @return [nil] 特記の必要がない場合
  attr_reader :railway_direction
  # @return [Integer] 所要時間（分）
  #  （API でのクラスは xsd:integer）
  attr_reader :necessary_time

  def self.factory_for_this_class
    factory_for_generating_platform_transfer_info_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_platform_info_transfer_info
  end

end