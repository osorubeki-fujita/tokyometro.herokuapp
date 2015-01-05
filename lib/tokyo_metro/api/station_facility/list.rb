# 各駅の駅施設情報の配列
class TokyoMetro::Api::StationFacility::List < TokyoMetro::Api::MetaClass::NotRealTime::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 2 )
  end

  include ::TokyoMetro::ApiModules::List::Seed

  alias :__seed__ :seed

  def seed_barrier_free_facility_infos
    __seed__( method_name: __method__ ) do
      self.each do | info |
        info.seed_barrier_free_facility_infos
      end
    end
  end

  def seed_platform_infos
    __seed__( method_name: __method__ ) do
      self.each.with_index(1) do | info , i |
        info.seed_platform_infos( whole: self.length , now_at: i )
      end
    end
  end

end