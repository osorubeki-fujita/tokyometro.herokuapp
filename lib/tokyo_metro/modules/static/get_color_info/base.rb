# 色の基本的な情報を取得するメソッドを提供するモジュール
module TokyoMetro::Modules::Static::GetColorInfo::Base

  # WebColor を返すメソッド
  # @return [String]
  def web_color
    @color.web_color
  end

  # Red, Green, Blue の各成分の情報を括弧で囲んだ文字列にして返すメソッド
  # @return [String]
  def rgb_in_parentheses
    @color.rgb_in_parentheses
  end

end