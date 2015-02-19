# 各種施設の配列
class TokyoMetro::Api::StationFacility::Info::BarrierFree::List < TokyoMetro::Api::MetaClass::Fundamental::List

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 1 )
  end

  def seed( station_facility_id , indent )
    super( station_facility_id , indent: indent + 1 , not_on_the_top_layer: true )
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_barrier_free_facilities_of_each_station
  end

end