# 文字列 (String) のクラスに組み込むモジュール
module ForRails::ExtendBuiltinLibraries::StringModule

  # バイナリか否かを判定するメソッド
  # @return [Boolean]
  # @note YAML でエラーが発生するのを防ぐために定義している。
  def is_binary_data?
    false # 日本語がバイナリとみなされるのを防ぐ
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  # @note 配列やハッシュを変換するメソッドから呼び出される。String のインスタンスは変換の必要がないが、to_s の alias として定義する。
  def to_strf( indent = 0 )
    " " * indent + self.to_s
  end

  # 全角数字を半角数字に変換するメソッド
  # @return [String]
  def zen_num_to_han
    Moji.zen_to_han( self , Moji::ZEN_ALNUM )
  end

  def convert_comma_between_number
    self.gsub( /(\d)、(\d)/ ) { $1 + "・" + $2 }
  end

  # 16進数の文字列か否かを判定するメソッド
  # @return [Boolean]
  def hex_string?
    /\A[\da-fA-F]+\Z/ === self
  end

# @!group WebColor を表す文字列に対するメソッド

  # WebColorの文字列（"#"なし）であるか否かを判定するメソッド
  # @return [Boolean]
  def is_web_color?
    self.hex_string? and self.length == 6
  end

  # WebColor の文字列（"#"あり）であるか否かを判定するメソッド
  # @return [Boolean]
  def is_web_color_with_sharp?
    if /\A\#(.+)\Z/ =~ self
      $1.is_web_color?
    else
      false
    end
  end

  # WebColor の文字列であるか否かを判定するメソッド
  # @return [Boolean]
  def is_improper_web_color?
    self.is_web_color? or self.is_web_color_with_sharp?
  end

  # WebColor を RgbColor に変換するメソッド
  # @return [::Array <Integer (natural number)>]
  def to_rgb_color
    unless self.is_improper_web_color?
      raise "Error"
    end
    self.gsub( /\#/ , "" ).each_char.each_slice(2).map{ | ary | ary.join.hex }
  end

  # @!endgroup

  def remove_dakuten
    h = {
      "が" => "か" ,
      "ぎ" => "き" ,
      "ぐ" => "く" ,
      "げ" => "け" ,
      "ご" => "こ" ,
      "ざ" => "さ" ,
      "じ" => "し" ,
      "ず" => "す" ,
      "ぜ" => "せ" ,
      "ぞ" => "そ" ,
      "だ" => "た" ,
      "ぢ" => "ち" ,
      "づ" => "つ" ,
      "で" => "て" ,
      "ど" => "と" ,
      "ば" => "は" ,
      "び" => "ひ" ,
      "ぶ" => "ふ" ,
      "べ" => "へ" ,
      "ぼ" => "ほ" ,
      "ぱ" => "は" ,
      "ぴ" => "ひ" ,
      "ぷ" => "ふ" ,
      "ぺ" => "へ" ,
      "ぽ" => "ほ"
    }

    self.gsub( /[#{h.keys.join}]/ , h )
  end

  def delete_station_subname
    regexp = ::ApplicationHelper.regexp_for_parentheses_ja
    self.gsub( regexp , "" )
  end

  def process_kouji
    kouji_regexp = ::ApplicationHelper.regexp_for_kouji
    self.gsub( kouji_regexp , "麴町" )
  end

  def process_specific_letter
    self.process_kouji
  end

  def station_name_in_title
    self.delete_station_subname.process_specific_letter
  end

end