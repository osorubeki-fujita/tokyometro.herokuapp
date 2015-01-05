# 2駅間の運賃の情報の配列
class TokyoMetro::Api::Fare::List < TokyoMetro::Api::MetaClass::NotRealTime::List

  include ::TokyoMetro::ApiModules::List::Seed
  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Fare

  alias :__seed__ :seed

  def seed
    normal_fares = ::NormalFareGroup.all
    __seed__ do
      self.each.with_index(1) do | fare , i |
        fare.seed( normal_fares )
        if i % 100 == 0
          puts i.to_s.rjust(5)
        end
      end
    end
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 2 )
  end

  # 運賃の額によってソートするメソッド
  # @return [List]
  def sort_by_fare
    self.class.new( self.sort_by{ | info | info.ticket_fare } )
  end

end