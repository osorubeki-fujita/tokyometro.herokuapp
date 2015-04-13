# 各種施設のメタクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Info < TokyoMetro::Api::MetaClass::NotRealTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::MetaClass

  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  include ::TokyoMetro::Modules::Api::Info::ToStringGeneral
  include ::TokyoMetro::Modules::Api::Info::SetDataToHash

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree
  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::LocatedArea

  # Constructor
  def initialize( id_urn , same_as , service_details , place_name , located_area_name , remark )
    @id_urn = id_urn
    @same_as = same_as
    @service_details = service_details
    @place_name = place_name
    @located_area_name = located_area_name
    @remark = remark

    # 利用可能な車いすの情報は、LinkForMobilityScooter, Escalator のクラスメソッドとして定義する。
  end

  # @return [String] 固有識別子
  # @note 命名ルールは「odpt.Facility:TokyoMetro.路線名.駅名.改札の内外.カテゴリ名.通し番号」
  attr_reader :same_as
  # @return [ServiceDetail::List] 施設の詳細情報
  attr_reader :service_details
  # @return [String] 施設の設置されている場所の名前
  attr_reader :place_name
  # @return [String] 施設の設置場所（改札内／改札外）
  attr_reader :located_area_name
  # @return [String] 補足事項
  attr_reader :remark

  alias :to_strf :to_s

  alias :located_area_name_ja :located_area_name

  def located_area_name_en
    if inside?
      "Inside"
    elsif outside?
      "Outside"
    else
      raise "Error"
    end
  end

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
      h = Hash.new

      set_data_to_hash( h , "\@id" , @id_urn )
      set_data_to_hash( h , "owl:sameAs" , @same_as )
      set_data_to_hash( h , "odpt:serviceDetail" , @service_details )
      set_data_to_hash( h , "odpt:placeName" , @place_name )
      set_data_to_hash( h , "odpt:locatedAreaName" , @located_area_name )
      set_data_to_hash( h , "ugsrv:remark" , @remark )

      set_data_to_hash( h , "ugsrv:categoryName" , self.class.category_name )

      # LinkForMobilityScooter, Escalator クラスのみに関連（他のクラスでは、self.class.spac__is_available_to は nil）
      set_data_to_hash( h , "spac:isAvailableTo" , self.class.spac__is_available_to )

      # Toilet クラスのみに関連（他のクラスでは @has_assistant は定義されないため、@has_assistant は nil を返す）
      set_data_to_hash( h , "spac:hasAssistant" , @has_assistant )

      h
  end

  def instance_in_db
    self.class.db_instance_class_of_barrier_free_facility_info.find_by_same_as( @same_as )
  end

  def self.factory_for_this_class
    factory_for_generating_barrier_free_info_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_barrier_free_facility_info
  end

  private

  def seed_service_detail( barrier_free_facility_id )
    raise unless barrier_free_facility_id.integer?
    @service_details.try( :seed , barrier_free_facility_id )
  end

end