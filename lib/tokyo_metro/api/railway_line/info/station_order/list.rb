# 駅の順序を扱う配列
class TokyoMetro::Api::RailwayLine::Info::StationOrder::List < ::TokyoMetro::Api::MetaClass::Fundamental::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 0 )
  end

  # @note {TokyoMetro::Api::RailwayLine::Info::StationOrder::Info#seed} を実行。
  def seed
    self.each do | info |
      info.seed
    end
  end

end