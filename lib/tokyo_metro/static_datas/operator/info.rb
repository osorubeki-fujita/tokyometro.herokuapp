# 個別の鉄道事業者の情報を扱うクラス
class TokyoMetro::StaticDatas::Operator::Info

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Operator
  include ::TokyoMetro::StaticDataModules::GetName
  include ::TokyoMetro::StaticDataModules::GenerateFromHashSetVariable

# @!group Constructor

  # Constructor
  # @param same_as [String] キー
  # @param name_ja [String] 事業者の名称（日本語、正式名）
  # @param name_ja_display [String] 事業者の名称（日本語、略称・表示用）
  # @param name_en [String] 事業者の名称（ローマ字表記、正式名）
  # @param name_en_display [String] 事業者の名称（ローマ字表記、略称・表示用）
  # @param index [Integer] 事業者の番号（整列のための定義）
  # @param numbering [Boolean] 駅ナンバリングを実施しているか否か
  # @param railway_line_code_shape [String or nil] 路線記号の形
  # @param station_code_shape [Stirng or nil] 駅番号の形
  # @param color [::TokyoMetro::StaticDatas::Color] 事業者の色
  def initialize( same_as , name_ja , name_ja_display , name_en , name_en_display , index , operator_code , numbering , railway_line_code_shape , station_code_shape , color )
    @same_as = same_as
    @name_ja = name_ja
    @name_ja_display = name_ja_display
    @name_en = name_en
    @name_en_display = name_en_display
    @index = index
    @operator_code = operator_code
    @numbering = numbering
    @railway_line_code_shape = railway_line_code_shape
    @station_code_shape = station_code_shape
    @color = color
  end

  attr_reader :operator_code

# @!group 鉄道事業者の ID、番号に関するメソッド

  # @return [String] 鉄道事業者の ID キー
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as }
  #   =>
  #   odpt.Operator:TokyoMetro
  #   odpt.Operator:Toei
  #   odpt.Operator:ToeiNipporiToneri
  #   odpt.Operator:Toden
  #   odpt.Operator:JR-East
  #   odpt.Operator:JR-Central
  #   odpt.Operator:Tokyu
  #   odpt.Operator:Odakyu
  #   odpt.Operator:Seibu
  #   odpt.Operator:Tobu
  #   odpt.Operator:SaitamaRailway
  #   odpt.Operator:ToyoRapidRailway
  #   odpt.Operator:Keio
  #   odpt.Operator:Keisei
  #   odpt.Operator:MIR
  #   odpt.Operator:Yurikamome
  #   odpt.Operator:TWR
  attr_reader :same_as

  # @return [String] 事業者の番号（整列のための定義）
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as.ljust(32) + " : " + operator.index.to_s.rjust(2) }
  #   =>
  #   odpt.Operator:TokyoMetro         :  1
  #   odpt.Operator:Toei               :  2
  #   odpt.Operator:ToeiNipporiToneri  :  3
  #   odpt.Operator:Toden              :  4
  #   odpt.Operator:JR-East            :  5
  #   odpt.Operator:JR-Central         :  6
  #   odpt.Operator:Tokyu              :  7
  #   odpt.Operator:Odakyu             :  8
  #   odpt.Operator:Seibu              :  9
  #   odpt.Operator:Tobu               : 10
  #   odpt.Operator:SaitamaRailway     : 11
  #   odpt.Operator:ToyoRapidRailway   : 12
  #   odpt.Operator:Keio               : 13
  #   odpt.Operator:Keisei             : 14
  #   odpt.Operator:MIR                : 15
  #   odpt.Operator:Yurikamome         : 16
  #   odpt.Operator:TWR                : 17
  attr_reader :index

# @!group 鉄道事業者の名称に関するメソッド (1) - インスタンス変数 正式名称

  # @return [String or ::Array] 鉄道事業者の事業者の名称（日本語、正式名称）
  # @note
  #  配列は、「都営地下鉄」（東京都交通局）、「都電」（東京都交通局）、「東急電鉄」（東京急行電鉄）、「つくばエクスプレス」（首都圏新都市鉄道）のように、事業者名よりも用いられることの多い（と思われる）事業名や別名、公式にも使われる略称などが存在する場合に用いる。
  #  なお、使用頻度が多いと思われる方が配列の先頭に来るよう定義する。
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as.ljust(32) + " : " + operator.name_ja.to_s }
  #   =>
  #   odpt.Operator:TokyoMetro         : ["東京メトロ", "東京地下鉄"]
  #   odpt.Operator:Toei               : ["都営地下鉄", "東京都交通局"]
  #   odpt.Operator:ToeiNipporiToneri  : ["都営", "東京都交通局"]
  #   odpt.Operator:Toden              : ["都電", "東京都交通局"]
  #   odpt.Operator:JR-East            : ["JR東日本", "東日本旅客鉄道"]
  #   odpt.Operator:JR-Central         : ["JR東海", "東海旅客鉄道"]
  #   odpt.Operator:Tokyu              : ["東急電鉄", "東京急行電鉄"]
  #   odpt.Operator:Odakyu             : 小田急電鉄
  #   odpt.Operator:Seibu              : 西武鉄道
  #   odpt.Operator:Tobu               : 東武鉄道
  #   odpt.Operator:SaitamaRailway     : 埼玉高速鉄道
  #   odpt.Operator:ToyoRapidRailway   : 東葉高速鉄道
  #   odpt.Operator:Keio               : 京王電鉄
  #   odpt.Operator:Keisei             : 京成電鉄
  #   odpt.Operator:MIR                : ["つくばエクスプレス", "首都圏新都市鉄道"]
  #   odpt.Operator:Yurikamome         : ゆりかもめ
  #   odpt.Operator:TWR                : ["りんかい線", "東京臨海高速鉄道"]
  attr_reader :name_ja

  # @return [String or ::Array] 鉄道事業者の事業者の名称（ローマ字表記、正式名称）
  # @note 配列を使用する基準については {#name_ja} を参照のこと。
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as.ljust(32) + " : " + operator.name_en.to_s }
  #   =>
  #   odpt.Operator:TokyoMetro         : Tokyo Metro
  #   odpt.Operator:Toei               : ["Toei Subway", "Bureau of Transportation Tokyo Metropolitan Government"]
  #   odpt.Operator:ToeiNipporiToneri  : ["Toei", "Bureau of Transportation Tokyo Metropolitan Government"]
  #   odpt.Operator:Toden              : ["Toden", "Bureau of Transportation Tokyo Metropolitan Government"]
  #   odpt.Operator:JR-East            : ["JR East", "East Japan Railway Company"]
  #   odpt.Operator:JR-Central         : ["JR Central", "Central Japan Railway Company"]
  #   odpt.Operator:Tokyu              : Tokyu Corporation
  #   odpt.Operator:Odakyu             : Odakyu Electric Railway
  #   odpt.Operator:Seibu              : Seibu Railway
  #   odpt.Operator:Tobu               : Tobu Railway
  #   odpt.Operator:SaitamaRailway     : Saitama Railway
  #   odpt.Operator:ToyoRapidRailway   : Toyo Rapid Railway
  #   odpt.Operator:Keio               : Keio Corporation
  #   odpt.Operator:Keisei             : Keisei Electric Railway
  #   odpt.Operator:MIR                : ["Tsukuba Express", "MIR", "Metropolitan Intercity Railway"]
  #   odpt.Operator:Yurikamome         : Yurikamome
  #   odpt.Operator:TWR                : ["Rinkai Line", "TWR", "Tokyo Waterfront Area Rapid Transit"]
  attr_reader :name_en

# @!group 鉄道事業者の名称に関するメソッド (2) - インスタンス変数 略称・表示用

  # @return [String or nil] 鉄道事業者の事業者の名称（日本語、略称・表示用）
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as.ljust(32) + " : " + operator.name_ja_display }
  #   =>
  #   odpt.Operator:TokyoMetro         : (nil)
  #   odpt.Operator:Toei               : 都営
  #   odpt.Operator:ToeiNipporiToneri  : （空文字列）
  #   odpt.Operator:Toden              : (nil)
  #   odpt.Operator:JR-East            : JR
  #   odpt.Operator:JR-Central         : JR
  #   odpt.Operator:Tokyu              : 東急
  #   odpt.Operator:Odakyu             : 小田急
  #   odpt.Operator:Seibu              : 西武
  #   odpt.Operator:Tobu               : 東武
  #   odpt.Operator:SaitamaRailway     : (nil)
  #   odpt.Operator:ToyoRapidRailway   : (nil)
  #   odpt.Operator:Keio               : 京王
  #   odpt.Operator:Keisei             : 京成
  #   odpt.Operator:MIR                : (nil)
  #   odpt.Operator:Yurikamome         : (nil)
  #   odpt.Operator:TWR                : (nil)
  attr_reader :name_ja_display

  # @return [String or nil] 鉄道事業者の事業者の名称（ローマ字表記、略称・表示用）
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as.ljust(32) + " : " + operator.name_en_display }
  #   =>
  #   odpt.Operator:TokyoMetro         : (nil)
  #   odpt.Operator:Toei               : Toei
  #   odpt.Operator:ToeiNipporiToneri  : （空文字列）
  #   odpt.Operator:Toden              : (nil)
  #   odpt.Operator:JR-East            : JR
  #   odpt.Operator:JR-Central         : JR
  #   odpt.Operator:Tokyu              : Tokyu
  #   odpt.Operator:Odakyu             : Odakyu
  #   odpt.Operator:Seibu              : Seibu
  #   odpt.Operator:Tobu               : Tobu
  #   odpt.Operator:SaitamaRailway     : (nil)
  #   odpt.Operator:ToyoRapidRailway   : (nil)
  #   odpt.Operator:Keio               : Keio
  #   odpt.Operator:Keisei             : Keisei
  #   odpt.Operator:MIR                : (nil)
  #   odpt.Operator:Yurikamome         : (nil)
  #   odpt.Operator:TWR                : (nil)
  attr_reader :name_en_display

# @!group 鉄道事業者の名称に関するメソッド (3) - 標準の名称（詳細版）

  # 鉄道事業者の標準の名称（日本語・詳細版）
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.name_ja_normal_precise }
  #   =>
  #   東京メトロ
  #   都営地下鉄
  #   都営
  #   都電
  #   JR東日本
  #   JR東海
  #   東急電鉄
  #   小田急電鉄
  #   西武鉄道
  #   東武鉄道
  #   埼玉高速鉄道
  #   東葉高速鉄道
  #   京王電鉄
  #   京成電鉄
  #   つくばエクスプレス
  #   ゆりかもめ
  #   りんかい線
  def name_ja_normal_precise
    get_name( @name_ja )
  end

  # 鉄道事業者の標準の名称（ローマ字表記・詳細版）
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.name_en_normal_precise }
  #   =>
  #   Tokyo Metro
  #   Toei Subway
  #   Toei
  #   Toden
  #   JR East
  #   JR Central
  #   Tokyu Corporation
  #   Odakyu Electric Railway
  #   Seibu Railway
  #   Tobu Railway
  #   Saitama Railway
  #   Toyo Rapid Railway
  #   Keio Corporation
  #   Keisei Electric Railway
  #   Tsukuba Express
  #   Yurikamome
  #   Rinkai Line
  def name_en_normal_precise
    get_name( @name_en )
  end

# @!group 鉄道事業者の名称に関するメソッド (4) - 標準の名称（簡易版）

  # 標準の名称（日本語・簡易版）
  # @return [String]
  # @note インスタンス変数 name_ja の値が文字列の場合は、インスタンス変数 name_ja の値を返す。
  # @note インスタンス変数 name_ja の値が配列の場合は、インスタンス変数 name_ja の最初の要素を返す。
  # @note JR各社については「JR」のみを返す。日暮里・舎人ライナーについては空文字列を返す。
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.name_ja_normal }
  #   =>
  #   東京メトロ
  #   都営
  #   （空文字列）
  #   都電
  #   JR
  #   JR
  #   東急
  #   小田急
  #   西武
  #   東武
  #   埼玉高速鉄道
  #   東葉高速鉄道
  #   京王
  #   京成
  #   つくばエクスプレス
  #   ゆりかもめ
  #   りんかい線
  def name_ja_normal
    unless @name_ja_display.nil?
      @name_ja_display
    else
      self.name_ja_normal_precise
    end
  end

  # 標準の名称（ローマ字表記）
  # @return [String]
  # @note インスタンス変数 name_en の値が文字列の場合は、インスタンス変数 name_en の値を返す。
  # @note インスタンス変数 name_en の値が配列の場合は、インスタンス変数 name_en の最初の要素を返す。
  # @note JR各社については「JR」のみを返す。日暮里・舎人ライナーについては空文字列を返す。
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.name_en_normal }
  #   =>
  #   Tokyo Metro
  #   Toei
  #   （空文字列）
  #   Toden
  #   JR
  #   JR
  #   Tokyu
  #   Odakyu
  #   Seibu
  #   Tobu
  #   Saitama Railway
  #   Toyo Rapid Railway
  #   Keio
  #   Keisei
  #   Tsukuba Express
  #   Yurikamome
  #   Rinkai Line
  def name_en_normal
    if @name_en_display.present?
      @name_en_display
    else
      self.name_en_normal_precise
    end
  end

# @!group 鉄道事業者の名称に関するメソッド (5) - 乗り換え等の情報で使用

  # 乗り換え等の情報で使用する名称（日本語）
  # @return [String]
  # @note インスタンス変数 name_ja_display が定義されている場合は name_ja_display の値を返す。
  # @note インスタンス変数 name_ja_display が定義されておらず、インスタンス変数 name の値が文字列の場合は、インスタンス変数 name の値を返す。
  # @note インスタンス変数 name_ja_display が定義されておらず、インスタンス変数 name の値が配列の場合は、インスタンス変数 name の最初の要素を返す。
  # @note 東京メトロ各線、日暮里・舎人ライナーについてはあえて表示をしない。
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as.ljust(32) + " : " + operator.name_ja_for_transfer_info }
  #   =>
  #   odpt.Operator:TokyoMetro         : (nil)
  #   odpt.Operator:Toei               : 都営
  #   odpt.Operator:ToeiNipporiToneri  : (nil)
  #   odpt.Operator:Toden              : 都電
  #   odpt.Operator:JR-East            : JR
  #   odpt.Operator:JR-Central         : JR
  #   odpt.Operator:Tokyu              : 東急
  #   odpt.Operator:Odakyu             : 小田急
  #   odpt.Operator:Seibu              : 西武
  #   odpt.Operator:Tobu               : 東武
  #   odpt.Operator:SaitamaRailway     : 埼玉高速鉄道
  #   odpt.Operator:ToyoRapidRailway   : 東葉高速鉄道
  #   odpt.Operator:Keio               : 京王
  #   odpt.Operator:Keisei             : 京成
  #   odpt.Operator:MIR                : つくばエクスプレス
  #   odpt.Operator:Yurikamome         : ゆりかもめ
  #   odpt.Operator:TWR                : りんかい線
  def name_ja_for_transfer_info
    case @same_as
    when "odpt.Operator:TokyoMetro" , "odpt.Operator:ToeiNipporiToneri"
      nil
    else
      self.name_ja_normal
    end
  end

  # 乗り換え等の情報で使用する名称（ローマ字表記）
  # @return [String]
  # @note インスタンス変数 name_en_display が定義されている場合は name_en_display の値を返す。
  # @note インスタンス変数 name_en_display が定義されておらず、インスタンス変数 name_en の値が文字列の場合は、インスタンス変数 name_en の値を返す。
  # @note インスタンス変数 name_en_display が定義されておらず、インスタンス変数 name_en の値が配列の場合は、インスタンス変数 name_en の最初の要素を返す。
  # @note 東京メトロ各線、日暮里・舎人ライナーについてはあえて表示をしない。
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as.ljust(32) + " : " + operator.name_en_for_transfer_info }
  #   =>
  #   odpt.Operator:TokyoMetro         : (nil)
  #   odpt.Operator:Toei               : Toei
  #   odpt.Operator:ToeiNipporiToneri  : (nil)
  #   odpt.Operator:Toden              : Toden
  #   odpt.Operator:JR-East            : JR
  #   odpt.Operator:JR-Central         : JR
  #   odpt.Operator:Tokyu              : Tokyu
  #   odpt.Operator:Odakyu             : Odakyu
  #   odpt.Operator:Seibu              : Seibu
  #   odpt.Operator:Tobu               : Tobu
  #   odpt.Operator:SaitamaRailway     : Saitama Railway
  #   odpt.Operator:ToyoRapidRailway   : Toyo Rapid Railway
  #   odpt.Operator:Keio               : Keio
  #   odpt.Operator:Keisei             : Keisei
  #   odpt.Operator:MIR                : Tsukuba Express
  #   odpt.Operator:Yurikamome         : Yurikamome
  #   odpt.Operator:TWR                : Rinkai Line
  def name_en_for_transfer_info
    case @same_as
    when "odpt.Operator:TokyoMetro" , "odpt.Operator:ToeiNipporiToneri"
      nil
    else
      self.name_en_normal
    end
  end

# @!group 鉄道事業者の名称に関するメソッド (6) - HAML

  # HAML に表示する名称（日本語）
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.name_ja_to_haml }
  #   =>
  #   東京メトロ
  #   都営地下鉄
  #   日暮里・舎人ライナー
  #   都電
  #   JR東日本
  #   JR東海
  #   東急電鉄
  #   小田急電鉄
  #   西武鉄道
  #   東武鉄道
  #   埼玉高速鉄道
  #   東葉高速鉄道
  #   京王電鉄
  #   京成電鉄
  #   つくばエクスプレス
  #   ゆりかもめ
  #   りんかい線
  def name_ja_to_haml
    case @same_as
    when "odpt.Operator:ToeiNipporiToneri"
      "日暮里・舎人ライナー"
    else
      if @name.instance_of?( ::Array ) and @name.length > 1
        "#{self.name_ja_normal_precise}（#{ @name[1] }）"
      else
        self.name_ja_normal_precise
      end
    end
  end

  # HAML に表示する名称（ローマ字表記）
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.name_en_to_haml }
  #   =>
  #   Tokyo Metro
  #   Toei Subway
  #   Nippori Toneri Liner
  #   Toden
  #   JR East
  #   JR Central
  #   Tokyu Corporation
  #   Odakyu Electric Railway
  #   Seibu Railway
  #   Tobu Railway
  #   Saitama Railway
  #   Toyo Rapid Railway
  #   Keio Corporation
  #   Keisei Electric Railway
  #   Tsukuba Express
  #   Yurikamome
  #   Rinkai Line
  def name_en_to_haml
    case @same_as
    when "odpt.Operator:ToeiNipporiToneri"
      "Nippori Toneri Liner"
    else
      if @name_en.instance_of?( ::Array ) and @name_en.length > 1
        "#{self.name_en_normal_precise} (#{ @name_en[1] })"
      else
        self.name_en_normal_precise
      end
    end
  end

# @!group 鉄道事業者の駅番号・路線番号に関するメソッド

  # @return [Boolean] 駅ナンバリングを実施しているか否か
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as.ljust(32) + " : " + operator.numbering.to_s }
  #   =>
  #   odpt.Operator:TokyoMetro         : true
  #   odpt.Operator:Toei               : true
  #   odpt.Operator:ToeiNipporiToneri  : true
  #   odpt.Operator:Toden              : false
  #   odpt.Operator:JR-East            : false
  #   odpt.Operator:JR-Central         : false
  #   odpt.Operator:Tokyu              : true
  #   odpt.Operator:Odakyu             : true
  #   odpt.Operator:Seibu              : true
  #   odpt.Operator:Tobu               : true
  #   odpt.Operator:SaitamaRailway     : false
  #   odpt.Operator:ToyoRapidRailway   : true
  #   odpt.Operator:Keio               : true
  #   odpt.Operator:Keisei             : true
  #   odpt.Operator:MIR                : true
  #   odpt.Operator:Yurikamome         : true
  #   odpt.Operator:TWR                : false
  attr_reader :numbering

  # @return [String or nil] 路線記号の形
  # @note 「縁取りあり・塗りつぶしなしの円」は "stroked_circle"、「縁取りあり・塗りつぶしなしの角丸四角形」は "stroked_rounded_square" とする。
  # @note 「縁取りなし・塗りつぶしありの角丸四角形」は "filled_rounded_square" とする。
  # @note 駅番号が定義されているが駅番号の図形・路線記号そのものを使用していない（数字のみ）の場合は "none" とする。
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as.ljust(32) + " : " + operator.railway_line_code_shape }
  #   =>
  #   odpt.Operator:TokyoMetro         : stroked_circle
  #   odpt.Operator:Toei               : stroked_circle
  #   odpt.Operator:ToeiNipporiToneri  : none
  #   odpt.Operator:Toden              : (nil)
  #   odpt.Operator:JR-East            : (nil)
  #   odpt.Operator:JR-Central         : (nil)
  #   odpt.Operator:Tokyu              : filled_rounded_square
  #   odpt.Operator:Odakyu             : stroked_circle
  #   odpt.Operator:Seibu              : filled_rounded_square
  #   odpt.Operator:Tobu               : stroked_rounded_square
  #   odpt.Operator:SaitamaRailway     : (nil)
  #   odpt.Operator:ToyoRapidRailway   : stroked_circle
  #   odpt.Operator:Keio               : stroked_circle
  #   odpt.Operator:Keisei             : stroked_circle
  #   odpt.Operator:MIR                : none
  #   odpt.Operator:Yurikamome         : none
  #   odpt.Operator:TWR                : (nil)
  attr_reader :railway_line_code_shape

  # @return [Stirng or nil] 駅番号の形
  # @note 「縁取りあり・塗りつぶしなしの円」は "stroked_circle"、「縁取りあり・塗りつぶしなしの角丸四角形」は "stroked_rounded_square" とする。
  # @note 西武鉄道については独特なデザインの角丸四角形であるため、"seibu_rounded_square" とする。
  # @note 駅番号が定義されているが図形を使用していない（数字のみ）の場合は "none" とする。
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.same_as.ljust(32) + " : " + operator.station_code_shape }
  #   =>
  #   odpt.Operator:TokyoMetro         : stroked_circle
  #   odpt.Operator:Toei               : stroked_circle
  #   odpt.Operator:ToeiNipporiToneri  : none
  #   odpt.Operator:Toden              : (nil)
  #   odpt.Operator:JR-East            : (nil)
  #   odpt.Operator:JR-Central         : (nil)
  #   odpt.Operator:Tokyu              : stroked_rounded_square
  #   odpt.Operator:Odakyu             : stroked_circle
  #   odpt.Operator:Seibu              : seibu_rounded_square
  #   odpt.Operator:Tobu               : stroked_rounded_square
  #   odpt.Operator:SaitamaRailway     : (nil)
  #   odpt.Operator:ToyoRapidRailway   : stroked_circle
  #   odpt.Operator:Keio               : stroked_circle
  #   odpt.Operator:Keisei             : stroked_circle
  #   odpt.Operator:MIR                : none
  #   odpt.Operator:Yurikamome         : none
  #   odpt.Operator:TWR                : (nil)
  attr_reader :station_code_shape

# @!group 鉄道事業者の色に関するメソッド (1)

  # @return [::TokyoMetro::StaticDatas::Color] 事業者の色
  attr_reader :color
  include ::TokyoMetro::StaticDataModules::GetColorInfo::Base

# @!group 鉄道事業者の色に関するメソッド (2)

  include ::TokyoMetro::StaticDataModules::GetColorInfo::EachRgbElement

# @!endgroup

  # CSS のクラスの名称
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.operators.each_value { | operator | puts operator.css_class_name }
  #   =>
  #   operator_tokyo_metro
  #   operator_toei_subway
  #   operator_nippori_toneri
  #   operator_toden
  #   operator_jr_east
  #   operator_jr_central
  #   operator_tokyu
  #   operator_odakyu
  #   operator_seibu
  #   operator_tobu
  #   operator_saitama
  #   operator_toyo_rapid
  #   operator_keio
  #   operator_keisei
  #   operator_tsukuba_exp
  #   operator_yurikamome
  #   operator_rinkai
  def css_class_name
    super( "" , :name_en_normal_precise )
  end

# @!group インスタンスの基本的な情報を取得するメソッド

  # インスタンスの比較に用いるメソッド
  # @return [Integer]
  def <=>( others )
    @index <=> others.index
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s( indent = 0 )
    self.instance_variables.map { |v|
      k = v.to_s.gsub( /\A\@/ , "" ).ljust(32)
      val = self.instance_variable_get(v)

      if val.instance_of?( ::Array )
        val = val.join("／")
      else
        val = val.to_s
      end

      " " * indent + k + val
    }.join( "\n" )
  end

# @!endgroup

  def seed
    ::Operator.create(
      same_as: @same_as ,
      name_ja: self.name_ja_inspect ,
      name_ja_display: @name_ja_display ,
      name_ja_normal_precise: self.name_ja_normal_precise ,
      name_ja_normal: self.name_ja_normal ,
      name_ja_for_transfer_info: self.name_ja_for_transfer_info ,
      name_ja_to_haml: self.name_ja_to_haml ,
      #
      # name_hira: self.name_hira ,
      #
      name_en: self.name_en_inspect ,
      name_en_display: @name_en_display ,
      name_en_normal_precise: self.name_en_normal_precise ,
      name_en_normal: self.name_en_normal ,
      name_en_for_transfer_info: self.name_en_for_transfer_info ,
      name_en_to_haml: self.name_en_to_haml ,
      #
      index: @index ,
      operator_code: @operator_code ,
      numbering: @numbering ,
      railway_line_code_shape: @railway_line_code_shape ,
      station_code_shape: @station_code_shape ,
      #
      color: self.web_color ,
      css_class_name: self.css_class_name
    )
  end

# @!group クラスメソッド

  # 与えられたハッシュからインスタンスを作成するメソッド
  # @param same_as [String] 作成するインスタンスの ID キー
  # @param h [Hash] ハッシュ
  # @return [Operator]
  def self.generate_from_hash( same_as , h )

    ary_of_keys_1 = [ :name_ja , :name_ja_display , :name_en , :name_en_display , :index ]
    name_ja , name_ja_display , name_en , name_en_display , index = ary_of_keys_1.map { | key | generate_from_hash__set_variable( h , key ) }

    numbering = generate_from_hash__set_variable( h , :numbering , boolean: true )

    ary_of_keys_2 = [ :operator_code , :railway_line_code_shape , :station_code_shape , :color ]
    operator_code , railway_line_code_shape , station_code_shape , color_base = ary_of_keys_2.map { | key | generate_from_hash__set_variable( h , key ) }

    if color_base.nil?
      raise "Error"
    end

    color = ::TokyoMetro::StaticDatas::Color::generate_from_hash( color_base )

    if numbering and railway_line_code_shape.nil? and station_code_shape == "none"
      railway_line_code_shape = "none"
    end

    self.new( same_as , name_ja , name_ja_display , name_en , name_en_display , index , operator_code , numbering , railway_line_code_shape , station_code_shape , color )
  end

# @!endgroup

end