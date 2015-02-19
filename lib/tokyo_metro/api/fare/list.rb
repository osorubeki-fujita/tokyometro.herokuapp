# 2駅間の運賃の情報の配列
class TokyoMetro::Api::Fare::List < TokyoMetro::Api::MetaClass::NotRealTime::List

  include ::TokyoMetro::ClassNameLibrary::Api::Fare
  include ::TokyoMetro::ClassNameLibrary::Static::Fare
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  def seed
    super( ::NormalFareGroup.all , ::Operator.all )
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
    self.class.new( self.sort_by( &:ticket_fare ) )
  end

end