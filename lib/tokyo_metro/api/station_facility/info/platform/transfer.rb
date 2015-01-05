# 乗り換えの情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::Platform::Transfer

  include ::TokyoMetro::ApiModules::ToFactoryClass::GenerateFromHash
  include ::TokyoMetro::ApiModules::Decision::RailwayLine

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

  def seed( station_facility_platform_info_id , indent: 0 )
    railway_line_id = seed__railway_line_instance_id
    railway_direction_id = seed__railway_direction_id( railway_line_id )

    ::StationFacilityPlatformInfoTransferInfo.create(
      railway_line_id: railway_line_id ,
      railway_direction_id: railway_direction_id ,
      necessary_time: @necessary_time ,
      station_facility_platform_info_id: station_facility_platform_info_id
    )
  end

  def self.factory_for_generating_from_hash
    ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::Platform::Transfer
  end

  private

  def seed__railway_line_instance_id
    railway_line_instance = ::RailwayLine.find_by( same_as: @railway_line )

    if railway_line_instance.nil?
      raise "Error: The instance of \"#{@railway_line}\" does not exist in the database"
    end

    railway_line_instance.id
  end

  def seed__railway_direction_id( railway_line_id )
    unless @railway_direction.nil?
      ::RailwayDirection.find_by( railway_line_id: railway_line_id , in_api_same_as: @railway_direction ).id
    else
      nil
    end
  end

end