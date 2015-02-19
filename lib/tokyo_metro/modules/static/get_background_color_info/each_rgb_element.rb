# 背景色の RGB の各成分の情報を取得するメソッドを提供するモジュール
module TokyoMetro::Modules::Static::GetBackgroundColorInfo::EachRgbElement

  # 背景色の R 成分の値を返すメソッド
  # @return [Integer]
  def bg_red
    @bgcolor.red
  end

  # 背景色の G 成分の値を返すメソッド
  # @return [Integer]
  def bg_green
    @bgcolor.green
  end

  # 背景色の B 成分の値を返すメソッド
  # @return [Integer]
  def bg_blue
    @bgcolor.blue
  end

end