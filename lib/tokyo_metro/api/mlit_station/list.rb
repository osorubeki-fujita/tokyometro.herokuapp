# 駅情報 mlit:Station の配列のクラス
class TokyoMetro::Api::MlitStation::List < TokyoMetro::Api::MlitRailwayLine::List
end

__END__

# 駅情報 mlit:Station の配列のクラス
class TokyoMetro::Api::MlitStation::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 2 )
  end

end