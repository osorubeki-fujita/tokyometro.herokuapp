# 各種施設のメタクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ApiModules::ToFactoryClass::GenerateFromHash
  include ::TokyoMetro::ApiModules::InstanceMethods::ToStringGeneral
  include ::TokyoMetro::ApiModules::InstanceMethods::SetDataToHash
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::MetaClass

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
    ::BarrierFreeFacility.find_by( same_as: @same_as )
  end

  def seed( facility_id )
    located_area_id = located_area_for_seeding
    type_id = type_for_seeding

    ::BarrierFreeFacility.create(
      station_facility_id: facility_id ,
      id_urn: @id_urn ,
      same_as: @same_as ,
      remark: @remark ,
      barrier_free_facility_located_area_id: located_area_id ,
      barrier_free_facility_type_id: type_id
    )
  end

  def seed_place_name_info( facility_id )
    if @place_name.present?
      ary = @place_name.split( "～" )
      case ary.length
      when 1
        place_name = ary.first
        seed_root_info( facility_id , place_name , 0 )
      else
        ary.each.with_index(1) do | place_name , i |
          seed_root_info( facility_id , place_name , i )
        end
      end
    end
  end

  # 補足情報 (service_detail) の流し込み
  # @param barrier_free_facility_id このインスタンスのDB内でのID
  def seed_additional_info( barrier_free_facility_id )
    @service_detail.seed( barrier_free_facility_id )
  end

  private

  def seed_root_info( facility_id , place_name , i )
    place_name_id = create_barrier_free_facility_place_name_and_get_id( place_name )
    ::BarrierFreeFacilityRootInfo.create(
      barrier_free_facility_id: facility_id ,
      barrier_free_facility_place_name_id: place_name_id ,
      index_in_root: i
    )
  end

  def create_barrier_free_facility_place_name_and_get_id( place_name )
    place_name_converted = place_name.zen_num_to_han
    h = { name_ja: place_name_converted }
    ::BarrierFreeFacilityPlaceName.find_or_create_by(h).id
  end

  def located_area_for_seeding
    ::BarrierFreeFacilityLocatedArea.find_or_create_by( { name_ja: @located_area_name } ).id
  end

  def type_for_seeding
    h = { name_ja: self.class.category_name , name_en: self.class.category_name_en }
    ::BarrierFreeFacilityType.find_or_create_by(h).id
  end

end