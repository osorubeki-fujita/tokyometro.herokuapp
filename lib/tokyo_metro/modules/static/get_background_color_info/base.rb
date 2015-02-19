# 背景色の基本的な情報を取得するメソッドを提供するモジュール
module TokyoMetro::Modules::Static::GetBackgroundColorInfo::Base

  # 背景の WebColor を返すメソッド
  # @return [String]
  def bg_web_color
    @bgcolor.web_color
  end

  # 背景の Red, Green, Blue の各成分の情報を括弧で囲んだ文字列にして返すメソッド
  # @return [String]
  def bg_rgb_in_parentheses
    @bgcolor.rgb_in_parentheses
  end

end