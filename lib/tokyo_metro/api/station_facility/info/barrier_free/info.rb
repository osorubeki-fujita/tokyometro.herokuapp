# 各種施設のメタクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Info < TokyoMetro::Api::MetaClass::NotRealTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::MetaClass

  include ::TokyoMetro::CommonModules::ToFactory::Generate::Info
  include ::TokyoMetro::CommonModules::ToFactory::Seed::Info

  include ::TokyoMetro::ApiModules::Info::ToStringGeneral
  include ::TokyoMetro::ApiModules::Info::SetDataToHash

  # Constructor
  def initialize( id_urn , same_as , service_detail , place_name , located_area_name , remark )
    @id_urn = id_urn
    @same_as = same_as
    @service_detail = service_detail
    @place_name = place_name
    @located_area_name = located_area_name
    @remark = remark

    # 利用可能な車いすの情報は、Link, Escalator のクラスメソッドとして定義する。
  end

  # @return [String] 固有識別子
  # @note 命名ルールは「odpt.Facility:TokyoMetro.路線名.駅名.改札の内外.カテゴリ名.通し番号」
  attr_reader :same_as
  # @return [ServiceDetail::Info] 施設の詳細情報
  attr_reader :service_detail
  # @return [String] 施設の設置されている場所の名前
  attr_reader :place_name
  # @return [String] 施設の設置場所（改札内／改札外）
  attr_reader :located_area_name
  # @return [String] 補足事項
  attr_reader :remark

  alias :to_strf :to_s

  def inside?
    @located_area_name == "改札内"
  end

  def outside?
    @located_area_name == "改札外"
  end

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
      h = Hash.new

      set_data_to_hash( h , "\@id" , @id_urn )
      set_data_to_hash( h , "owl:sameAs" , @same_as )
      set_data_to_hash( h , "odpt:serviceDetail" , @service_detail )
      set_data_to_hash( h , "odpt:placeName" , @place_name )
      set_data_to_hash( h , "odpt:locatedAreaName" , @located_area_name )
      set_data_to_hash( h , "ugsrv:remark" , @remark )

      set_data_to_hash( h , "ugsrv:categoryName" , self.class.category_name )

      # Link, Escalator クラスのみに関連（他のクラスでは、self.class.spac__is_available_to は nil）
      set_data_to_hash( h , "spac:isAvailableTo" , self.class.spac__is_available_to )

      # Toilet クラスのみに関連（他のクラスでは @has_assistant は定義されないため、@has_assistant は nil を返す）
      set_data_to_hash( h , "spac:hasAssistant" , @has_assistant )

      h
  end

  def instance_in_db
    ::BarrierFreeFacility.find_by_same_as( @same_as )
  end

  def self.factory_for_this_class
    factory_for_generating_barrier_free_info_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_barrier_free_facility_info
  end

  private

  def seed_service_detail( barrier_free_facility_id )
    @service_detail.try( :seed , barrier_free_facility_id )
  end

end