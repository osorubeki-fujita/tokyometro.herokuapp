# 個別の駅施設情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info < TokyoMetro::Api::MetaClass::NotRealTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  include ::TokyoMetro::Modules::Api::Info::ToStringWithArray

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
  # @return [Platform::List]
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

  def seed_barrier_free_facilities( indent )
    seed_barrier_free_facilities_or_platform_infos( @barrier_free_facilities , indent )
  end

  def seed_platform_infos( indent )
    seed_barrier_free_facilities_or_platform_infos( @platform_infos , indent )
  end

  def seed_barrier_free_facilities_or_platform_infos( info , indent )
    station_facility_id = instance_in_db.id
    info.try( :seed , station_facility_id , indent )
  end

  def instance_in_db
    ::StationFacility.find_by_same_as( @same_as )
  end

  # @!endgroup

end