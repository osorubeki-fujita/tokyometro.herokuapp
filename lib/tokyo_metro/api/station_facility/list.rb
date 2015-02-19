# 各駅の駅施設情報の配列
class TokyoMetro::Api::StationFacility::List < TokyoMetro::Api::MetaClass::NotRealTime::List

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  def barrier_free_facilities
    self.class.barrier_free_list_class.new( self.map( &:barrier_free_facilities ).flatten )
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 2 )
  end

  def seed_barrier_free_facilities
    __seed__(
      factory_name: :factory_for_seeding_barrier_free_facilities ,
      method_name: __method__ ,
      indent: 0 ,
      not_on_the_top_layer: false ,
      display_number: true
    )
  end

  def seed_platform_infos
    __seed__(
      factory_name: :factory_for_seeding_platform_infos ,
      method_name: __method__ ,
      indent: 0 ,
      not_on_the_top_layer: false ,
      display_number: true
    )
  end

end