# 個別の駅施設情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info < TokyoMetro::Api::MetaClass::NotRealTime::Info

  include ::TokyoMetro::ApiModules::InstanceMethods::ToStringWithArray
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  # Constructor
  def initialize( id_urn , same_as , barrier_free_facilities , platform_infos , dc_date )
    @id_urn = id_urn
    @same_as = same_as
    @barrier_free_facilities = barrier_free_facilities
    @platform_infos = platform_infos
    @dc_date = dc_date
  end

  # 固有識別子 - URL
  # @return [String]
  # @note 命名ルールは「odpt.StationFacility:TokyoMetro.駅名」
  attr_reader :same_as

  # 駅の施設一覧 - (ug:SpatialThing) odpt:barrierfreeFacility
  # @return [BarrierFreeFacilitry::List]
  attr_reader :barrier_free_facilities

  # プラットフォームに車両が停車している時の、車両毎の最寄りの施設・出口等の情報 - Array (ug:SpatialThing) odpt:platformInformation
  # @return [PlatformInfo::List]
  attr_reader :platform_infos

  # @todo 定義されているのか？
  attr_reader :dc_date

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
      h = Hash.new

      set_data_to_hash( h , "\@id" , @id_urn )
      set_data_to_hash( h , "owl:sameAs" , @same_as )
      set_data_to_hash( h , "dc:date" , @dc_date.to_s )
      set_data_to_hash( h , "odpt:barrierfreeFacility" , @barrier_free_facilities )
      set_data_to_hash( h , "odpt:platformInformation" , @platform_infos )

      h
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    to_s_with_array( [ "odpt:barrierfreeFacility" ,  "odpt:platformInformation" ] , indent )
  end

  def seed
    seed_h = {
      id_urn: @id_urn ,
      same_as: @same_as ,
      dc_date: @dc_date
    }
    ::StationFacility.create( seed_h )
  end

  def seed_barrier_free_facility_infos
    puts " " * 4 + @same_as

    station_facility_id = instance_in_db.id
    @barrier_free_facilities.seed( station_facility_id , indent: 1 )
  end

  def seed_platform_infos( whole: nil , now_at: nil )
    station_facility_id = instance_in_db.id
    @platform_infos.seed( station_facility_id , whole: whole , now_at: now_at )
  end

  def instance_in_db
    ::StationFacility.find_by( same_as: @same_as )
  end

  # @!endgroup

end