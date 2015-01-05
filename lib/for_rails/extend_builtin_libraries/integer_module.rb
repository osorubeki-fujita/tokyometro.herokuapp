# 整数のクラス
module ForRails::ExtendBuiltinLibraries::IntegerModule

  # n 桁（デフォルトは3桁）ごとに文字 separator （デフォルトは “,” ）で区切るメソッド
  # @return [String]
  def to_currency( n = 3 , separator = "," )
    self.to_s.reverse.gsub( /(\d{#{n}})(?=\d)/ , '\1' + separator ).reverse
  end

  # 16進数の文字列に変換するメソッド
  # @return [String]
  def to_two_digit_hex
    str = self.to_s(16)
    if str.length == 1
      str = "0" + str
    end
    str
  end

  def meaningful?
    self > 0
  end

end