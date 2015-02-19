# 地物情報 ug:Poi の配列のクラス
class TokyoMetro::Api::Point::List < TokyoMetro::Api::MetaClass::Hybrid::List

  include ::TokyoMetro::ClassNameLibrary::Api::Point
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  undef :find_by_same_as

  def seed
    super( ::Station.all , display_number: true )
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 2 )
  end

end