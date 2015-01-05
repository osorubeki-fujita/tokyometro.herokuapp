# 地物情報 ug:Poi の配列のクラス
class TokyoMetro::Api::Point::List < TokyoMetro::Api::MetaClass::Hybrid::List

  include TokyoMetro::ApiModules::List::Seed

  alias :__seed__ :seed

  def seed
    stations = ::Station.all
    __seed__ do
      self.each do |v|
        v.seed( stations )
      end
    end
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 2 )
  end

end