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
    ::Moji.zen_to_han( self , ::Moji::ZEN_ALNUM )
  end

  # 全角アルファベットを半角アルファベットに変換するメソッド
  # @return [String]
  def zen_alphabet_to_han
    ::Moji.zen_to_han( self , ::Moji::ZEN_ALPHA )
  end

  def process_train_information_text
    str = self
    str = str.zen_num_to_han
    str = str.zen_alphabet_to_han
    str = str.gsub( /[〜～]/ , " - " )

    regexp_1 = /\A(.+(?:線|ライン)内)で(?:発生した|の)?(?:、?)(.+)のため(?:、?)/
    regexp_2 = /\A(.+(?:線|ライン)) (.+?)駅? - (.+?)駅?間?で(?:発生した|の)?(?:、?)(.+)のため(?:、?)/
    regexp_3 = /\A(.+(?:線|ライン)) (.+?)駅?で(?:発生した|の)?(?:、?)(.+)のため(?:、?)/

    case str
    when regexp_1
      str = str.gsub( regexp_1 ) { "#{ $1 }での#{ $2 }により、" }
    when regexp_2
      str = str.gsub( regexp_2 ) { "#{ $1 } #{ $2 } - #{ $3 } での#{ $4 }により、" }
    when regexp_3
      str = str.gsub( regexp_3 ) { "#{ $1 } #{ $2 }駅での#{ $3 }により、" }
    end

    regexp_cause = /での(.+)により、/
    if regexp_cause =~ str
      case $1
      when "車両点検" , "踏切安全確認"
        str = str.gsub( regexp_cause ) { "で行なった#{ $1 }の影響で、" }
      end
    end

    str = str.gsub( /。\n?(?!\Z)/ , "。\n" )
    str = str.gsub( /に(?=振替輸送を実施しています。)/ , "で" )
    str = str.gsub( /(?<=詳しくは)、(?=駅係員にお尋ねください。)/ , "" )
    str
  end

  def convert_comma_between_number
    gsub( /(\d)、(\d)/ ) { $1 + "・" + $2 }
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
    hex_string? and length == 6
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
    is_web_color? or is_web_color_with_sharp?
  end

  # WebColor を RgbColor に変換するメソッド
  # @return [::Array <Integer (natural number)>]
  def to_rgb_color
    unless is_improper_web_color?
      raise "Error"
    end
    gsub( /\#/ , "" ).each_char.each_slice(2).map{ | ary | ary.join.hex }
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

    gsub( /[#{h.keys.join}]/ , h )
  end

  def delete_station_subname
    regexp = ::ApplicationHelper.regexp_for_parentheses_normal
    gsub( regexp , "" )
  end

  def process_kouji
    kouji_regexp = ::ApplicationHelper.regexp_for_kouji
    gsub( kouji_regexp , "麴町" )
  end

  def process_specific_letter
    process_kouji
  end

  def station_name_in_title
    delete_station_subname.process_specific_letter
  end

  def to_time_hm_array
    if /\A\d{1,2}\:\d{1,2}\Z/ === self
      split( /\:/ ).map( &:to_i )
    else
      raise "Error: #{ self } (#{self.class.name}) is not valid."
    end
  end

  # ファイル名を処理するメソッド
  def convert_yen_to_slash
    gsub( /\// , "\\" )
  end

end