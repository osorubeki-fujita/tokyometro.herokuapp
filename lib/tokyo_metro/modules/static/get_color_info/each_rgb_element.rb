# 色の RGB の各成分の情報を取得するメソッドを提供するモジュール
module TokyoMetro::Modules::Static::GetColorInfo::EachRgbElement

  # R 成分の値を返すメソッド
  # @return [Integer]
  def red
    @color.red
  end

  # G 成分の値を返すメソッド
  # @return [Integer]
  def green
    @color.green
  end

  # B 成分の値を返すメソッド
  # @return [Integer]
  def blue
    @color.blue
  end

end