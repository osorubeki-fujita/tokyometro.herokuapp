# 路線情報 mlit:Railway の配列のクラス
class TokyoMetro::Api::MlitRailwayLine::List < TokyoMetro::Api::MetaClass::Geo::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 2 )
  end

end