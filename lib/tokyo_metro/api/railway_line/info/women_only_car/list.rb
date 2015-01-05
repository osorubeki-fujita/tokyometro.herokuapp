# 女性専用車両の情報のリスト（複数の情報）を扱う配列
class TokyoMetro::Api::RailwayLine::Info::WomenOnlyCar::List < ::TokyoMetro::Api::MetaClass::Fundamental::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 1 )
  end

  def seed( railway_line_id )
    self.each do | info |
      info.seed( railway_line_id )
    end
  end

end