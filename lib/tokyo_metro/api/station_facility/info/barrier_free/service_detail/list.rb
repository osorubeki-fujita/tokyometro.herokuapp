# 施設の詳細情報の配列を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::ServiceDetail::List < TokyoMetro::Api::MetaClass::Fundamental::List

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  # インスタンスの情報を文字列に変換するメソッド
  # @return [String]
  def to_s
    self.map( &:to_s ).join("／")
  end

  alias :to_strf :to_s

  undef :find_by_same_as

  def seed( barrier_free_facility_id )
    raise unless barrier_free_facility_id.integer?
    super( barrier_free_facility_id , not_on_the_top_layer: true , no_display: true , display_number: false )
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_barrier_free_facility_service_detail_list
  end

end