# 個別の路線の情報を扱うクラス
class TokyoMetro::StaticDatas::RailwayLine::Info

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::RailwayLine
  include ::TokyoMetro::StaticDataModules::GenerateFromHashSetVariable
  include ::TokyoMetro::StaticDataModules::GetName

  # Constructor
  def initialize( same_as , name_ja , name_hira , name_en , name_code , operator , index , color )
    @same_as = same_as
    @name_ja = name_ja
    @name_hira = name_hira
    @name_en = name_en
    @name_code = name_code
    @index = index
    @color = color
    @operator = operator
  end

  # インスタンスの比較に用いるメソッド
  # @return [Integer]
  def <=>( other )
    if @operator.same_as == other.operator.same_as
      @index <=> other.index
    else
      @operator <=> other.operator
    end
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s( indent = 0 )
    str_1 = self.instance_variables.map { |v|
      k = v.to_s.gsub( /\A\@/ , "" ).ljust(32)
      val = self.instance_variable_get(v)

      if v == :@operator
        val = "\n" + val.to_s( indent + 2 )
      elsif val.instance_of?( ::Array )
        val = val.join("／")
      else
        val = val.to_s
      end

      " " * indent + k + val
    }.join( "\n" )

    str_2 = [ :name_ja_with_operator_name , :name_en_with_operator_name , :css_class_name ].map { |v|
      k = v.to_s.ljust(32)
      val = self.__send__(v)
      " " * indent + k + val
    }.join( "\n" )

    [ "=" * 96 , str_1 , "-" * 96 , str_2 ].join( "\n" )
  end

# @!group 路線の ID に関するメソッド

  # @return [String] 路線の ID キー
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza
  #   odpt.Railway:TokyoMetro.Marunouchi
  #   odpt.Railway:TokyoMetro.MarunouchiBranch
  #   odpt.Railway:TokyoMetro.Hibiya
  #   odpt.Railway:TokyoMetro.Tozai
  #   odpt.Railway:TokyoMetro.Chiyoda
  #   odpt.Railway:TokyoMetro.Yurakucho
  #   odpt.Railway:TokyoMetro.Hanzomon
  #   odpt.Railway:TokyoMetro.Namboku
  #   odpt.Railway:TokyoMetro.Fukutoshin
  #   odpt.Railway:Toei.Asakusa
  #   odpt.Railway:Toei.Mita
  #   odpt.Railway:Toei.Shinjuku
  #   odpt.Railway:Toei.Oedo
  #   odpt.Railway:Toei.NipporiToneri
  #   odpt.Railway:Toei.TodenArakawa
  #   odpt.Railway:JR-East.Yamanote
  #   odpt.Railway:JR-East.KeihinTohoku
  #   odpt.Railway:JR-East.Tokaido
  #   odpt.Railway:JR-East.Yokosuka
  #   odpt.Railway:JR-East.Takasaki
  #   odpt.Railway:JR-East.Utsunomiya
  #   odpt.Railway:JR-East.ShonanShinjuku
  #   odpt.Railway:JR-East.UenoTokyo
  #   odpt.Railway:JR-East.Chuo
  #   odpt.Railway:JR-East.ChuoKaisoku
  #   odpt.Railway:JR-East.ChuoSobu
  #   odpt.Railway:JR-East.Sobu
  #   odpt.Railway:JR-East.NaritaExpress
  #   odpt.Railway:JR-East.Saikyo
  #   odpt.Railway:JR-East.Joban
  #   odpt.Railway:JR-East.Keiyo
  #   odpt.Railway:JR-East.Musashino
  #   odpt.Railway:JR-East.Shinkansen
  #   odpt.Railway:JR-Tokai.Shinkansen
  #   odpt.Railway:Tokyu.Toyoko
  #   odpt.Railway:Tokyu.Meguro
  #   odpt.Railway:Tokyu.DenEnToshi
  #   odpt.Railway:Odakyu.Odawara
  #   odpt.Railway:Odakyu.Tama
  #   odpt.Railway:Odakyu.Enoshima
  #   odpt.Railway:Seibu.Ikebukuro
  #   odpt.Railway:Seibu.SeibuYurakucho
  #   odpt.Railway:Seibu.Sayama
  #   odpt.Railway:Seibu.Shinjuku
  #   odpt.Railway:Tobu.SkyTreeIsesaki
  #   odpt.Railway:Tobu.Skytree
  #   odpt.Railway:Tobu.Isesaki
  #   odpt.Railway:Tobu.Nikko
  #   odpt.Railway:Tobu.Tojo
  #   odpt.Railway:SaitamaRailway.SaitamaRailway
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway
  #   odpt.Railway:Keio.Keio
  #   odpt.Railway:Keio.New
  #   odpt.Railway:Keio.Inokashira
  #   odpt.Railway:Keisei.KeiseiMain
  #   odpt.Railway:Keisei.KeiseiOshiage
  #   odpt.Railway:MIR.TX
  #   odpt.Railway:Yurikamome.Yurikamome
  #   odpt.Railway:TWR.Rinkai
  attr_reader :same_as

# @!group 路線の記号・番号に関するメソッド

  # @return [String or ::Array] 路線記号
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.name_code }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : G
  #   odpt.Railway:TokyoMetro.Marunouchi               : M
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : m
  #   odpt.Railway:TokyoMetro.Hibiya                   : H
  #   odpt.Railway:TokyoMetro.Tozai                    : T
  #   odpt.Railway:TokyoMetro.Chiyoda                  : C
  #   odpt.Railway:TokyoMetro.Yurakucho                : Y
  #   odpt.Railway:TokyoMetro.Hanzomon                 : Z
  #   odpt.Railway:TokyoMetro.Namboku                  : N
  #   odpt.Railway:TokyoMetro.Fukutoshin               : F
  #   odpt.Railway:Toei.Asakusa                        : A
  #   odpt.Railway:Toei.Mita                           : I
  #   odpt.Railway:Toei.Shinjuku                       : S
  #   odpt.Railway:Toei.Oedo                           : E
  #   odpt.Railway:Toei.NipporiToneri                  : (nil)
  #   odpt.Railway:Toei.TodenArakawa                   : (nil)
  #   odpt.Railway:JR-East.Yamanote                    : (nil)
  #   odpt.Railway:JR-East.KeihinTohoku                : (nil)
  #   odpt.Railway:JR-East.Tokaido                     : (nil)
  #   odpt.Railway:JR-East.Yokosuka                    : (nil)
  #   odpt.Railway:JR-East.Takasaki                    : (nil)
  #   odpt.Railway:JR-East.Utsunomiya                  : (nil)
  #   odpt.Railway:JR-East.ShonanShinjuku              : (nil)
  #   odpt.Railway:JR-East.UenoTokyo                   : (nil)
  #   odpt.Railway:JR-East.Chuo                        : (nil)
  #   odpt.Railway:JR-East.ChuoKaisoku                 : (nil)
  #   odpt.Railway:JR-East.ChuoSobu                    : (nil)
  #   odpt.Railway:JR-East.Sobu                        : (nil)
  #   odpt.Railway:JR-East.NaritaExpress               : (nil)
  #   odpt.Railway:JR-East.Saikyo                      : (nil)
  #   odpt.Railway:JR-East.Joban                       : (nil)
  #   odpt.Railway:JR-East.Keiyo                       : (nil)
  #   odpt.Railway:JR-East.Musashino                   : (nil)
  #   odpt.Railway:JR-East.Shinkansen                  : (nil)
  #   odpt.Railway:JR-Tokai.Shinkansen                 : (nil)
  #   odpt.Railway:Tokyu.Toyoko                        : TY
  #   odpt.Railway:Tokyu.Meguro                        : MG
  #   odpt.Railway:Tokyu.DenEnToshi                    : DT
  #   odpt.Railway:Odakyu.Odawara                      : OH
  #   odpt.Railway:Odakyu.Tama                         : OT
  #   odpt.Railway:Odakyu.Enoshima                     : OE
  #   odpt.Railway:Seibu.Ikebukuro                     : SI
  #   odpt.Railway:Seibu.SeibuYurakucho                : SI
  #   odpt.Railway:Seibu.Sayama                        : SY
  #   odpt.Railway:Seibu.Shinjuku                      : SS
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : ["TS", "TI"]
  #   odpt.Railway:Tobu.Skytree                        : TS
  #   odpt.Railway:Tobu.Isesaki                        : TI
  #   odpt.Railway:Tobu.Nikko                          : TN
  #   odpt.Railway:Tobu.Tojo                           : TJ
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : (nil)
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : (nil)
  #   odpt.Railway:Keio.Keio                           : KO
  #   odpt.Railway:Keio.New                            : KO
  #   odpt.Railway:Keio.Inokashira                     : IK
  #   odpt.Railway:Keisei.KeiseiMain                   : (nil)
  #   odpt.Railway:Keisei.KeiseiOshiage                : (nil)
  #   odpt.Railway:MIR.TX                              : (nil)
  #   odpt.Railway:Yurikamome.Yurikamome               : (nil)
  #   odpt.Railway:TWR.Rinkai                          : (nil)
  attr_reader :name_code

  # 標準の路線記号を取得するメソッド
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.name_code_normal }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : G
  #   odpt.Railway:TokyoMetro.Marunouchi               : M
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : m
  #   odpt.Railway:TokyoMetro.Hibiya                   : H
  #   odpt.Railway:TokyoMetro.Tozai                    : T
  #   odpt.Railway:TokyoMetro.Chiyoda                  : C
  #   odpt.Railway:TokyoMetro.Yurakucho                : Y
  #   odpt.Railway:TokyoMetro.Hanzomon                 : Z
  #   odpt.Railway:TokyoMetro.Namboku                  : N
  #   odpt.Railway:TokyoMetro.Fukutoshin               : F
  #   odpt.Railway:Toei.Asakusa                        : A
  #   odpt.Railway:Toei.Mita                           : I
  #   odpt.Railway:Toei.Shinjuku                       : S
  #   odpt.Railway:Toei.Oedo                           : E
  #   odpt.Railway:Toei.NipporiToneri                  : (nil)
  #   odpt.Railway:Toei.TodenArakawa                   : (nil)
  #   odpt.Railway:JR-East.Yamanote                    : (nil)
  #   odpt.Railway:JR-East.KeihinTohoku                : (nil)
  #   odpt.Railway:JR-East.Tokaido                     : (nil)
  #   odpt.Railway:JR-East.Yokosuka                    : (nil)
  #   odpt.Railway:JR-East.Takasaki                    : (nil)
  #   odpt.Railway:JR-East.Utsunomiya                  : (nil)
  #   odpt.Railway:JR-East.ShonanShinjuku              : (nil)
  #   odpt.Railway:JR-East.UenoTokyo                   : (nil)
  #   odpt.Railway:JR-East.Chuo                        : (nil)
  #   odpt.Railway:JR-East.ChuoKaisoku                 : (nil)
  #   odpt.Railway:JR-East.ChuoSobu                    : (nil)
  #   odpt.Railway:JR-East.Sobu                        : (nil)
  #   odpt.Railway:JR-East.NaritaExpress               : (nil)
  #   odpt.Railway:JR-East.Saikyo                      : (nil)
  #   odpt.Railway:JR-East.Joban                       : (nil)
  #   odpt.Railway:JR-East.Keiyo                       : (nil)
  #   odpt.Railway:JR-East.Musashino                   : (nil)
  #   odpt.Railway:JR-East.Shinkansen                  : (nil)
  #   odpt.Railway:JR-Tokai.Shinkansen                 : (nil)
  #   odpt.Railway:Tokyu.Toyoko                        : TY
  #   odpt.Railway:Tokyu.Meguro                        : MG
  #   odpt.Railway:Tokyu.DenEnToshi                    : DT
  #   odpt.Railway:Odakyu.Odawara                      : OH
  #   odpt.Railway:Odakyu.Tama                         : OT
  #   odpt.Railway:Odakyu.Enoshima                     : OE
  #   odpt.Railway:Seibu.Ikebukuro                     : SI
  #   odpt.Railway:Seibu.SeibuYurakucho                : SI
  #   odpt.Railway:Seibu.Sayama                        : SY
  #   odpt.Railway:Seibu.Shinjuku                      : SS
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : TS
  #   odpt.Railway:Tobu.Skytree                        : TS
  #   odpt.Railway:Tobu.Isesaki                        : TI
  #   odpt.Railway:Tobu.Nikko                          : TN
  #   odpt.Railway:Tobu.Tojo                           : TJ
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : (nil)
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : (nil)
  #   odpt.Railway:Keio.Keio                           : KO
  #   odpt.Railway:Keio.New                            : KO
  #   odpt.Railway:Keio.Inokashira                     : IK
  #   odpt.Railway:Keisei.KeiseiMain                   : (nil)
  #   odpt.Railway:Keisei.KeiseiOshiage                : (nil)
  #   odpt.Railway:MIR.TX                              : (nil)
  #   odpt.Railway:Yurikamome.Yurikamome               : (nil)
  #   odpt.Railway:TWR.Rinkai                          : (nil)
  def name_code_normal
    if @name_code.instance_of?( ::Array )
      @name_code.first
    else
      @name_code
    end
  end

  # @return [Integer] 同一事業者内での路線の番号（整列のために定義）
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.index.to_s.rjust(2) }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    :  1
  #   odpt.Railway:TokyoMetro.Marunouchi               :  2
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : 2.1
  #   odpt.Railway:TokyoMetro.Hibiya                   :  3
  #   odpt.Railway:TokyoMetro.Tozai                    :  4
  #   odpt.Railway:TokyoMetro.Chiyoda                  :  5
  #   odpt.Railway:TokyoMetro.Yurakucho                :  6
  #   odpt.Railway:TokyoMetro.Hanzomon                 :  7
  #   odpt.Railway:TokyoMetro.Namboku                  :  8
  #   odpt.Railway:TokyoMetro.Fukutoshin               :  9
  #   odpt.Railway:Toei.Asakusa                        :  1
  #   odpt.Railway:Toei.Mita                           :  2
  #   odpt.Railway:Toei.Shinjuku                       :  3
  #   odpt.Railway:Toei.Oedo                           :  4
  #   odpt.Railway:Toei.NipporiToneri                  :  5
  #   odpt.Railway:Toei.TodenArakawa                   :  6
  #   odpt.Railway:JR-East.Yamanote                    :  1
  #   odpt.Railway:JR-East.KeihinTohoku                :  2
  #   odpt.Railway:JR-East.Tokaido                     :  3
  #   odpt.Railway:JR-East.Yokosuka                    :  4
  #   odpt.Railway:JR-East.Takasaki                    :  5
  #   odpt.Railway:JR-East.Utsunomiya                  :  6
  #   odpt.Railway:JR-East.ShonanShinjuku              :  7
  #   odpt.Railway:JR-East.UenoTokyo                   :  8
  #   odpt.Railway:JR-East.Chuo                        :  9
  #   odpt.Railway:JR-East.ChuoKaisoku                 : 10
  #   odpt.Railway:JR-East.ChuoSobu                    : 11
  #   odpt.Railway:JR-East.Sobu                        : 12
  #   odpt.Railway:JR-East.NaritaExpress               : 13
  #   odpt.Railway:JR-East.Saikyo                      : 14
  #   odpt.Railway:JR-East.Joban                       : 15
  #   odpt.Railway:JR-East.Keiyo                       : 16
  #   odpt.Railway:JR-East.Musashino                   : 17
  #   odpt.Railway:JR-East.Shinkansen                  : 18
  #   odpt.Railway:JR-Tokai.Shinkansen                 :  1
  #   odpt.Railway:Tokyu.Toyoko                        :  1
  #   odpt.Railway:Tokyu.Meguro                        :  2
  #   odpt.Railway:Tokyu.DenEnToshi                    :  3
  #   odpt.Railway:Odakyu.Odawara                      :  1
  #   odpt.Railway:Odakyu.Tama                         :  2
  #   odpt.Railway:Odakyu.Enoshima                     :  3
  #   odpt.Railway:Seibu.Ikebukuro                     :  1
  #   odpt.Railway:Seibu.SeibuYurakucho                :  5
  #   odpt.Railway:Seibu.Sayama                        :  4
  #   odpt.Railway:Seibu.Shinjuku                      :  6
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 :  1
  #   odpt.Railway:Tobu.Skytree                        : 1.1
  #   odpt.Railway:Tobu.Isesaki                        :  2
  #   odpt.Railway:Tobu.Nikko                          :  3
  #   odpt.Railway:Tobu.Tojo                           :  5
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       :  1
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   :  1
  #   odpt.Railway:Keio.Keio                           :  1
  #   odpt.Railway:Keio.New                            :  2
  #   odpt.Railway:Keio.Inokashira                     :  3
  #   odpt.Railway:Keisei.KeiseiMain                   :  1
  #   odpt.Railway:Keisei.KeiseiOshiage                :  2
  #   odpt.Railway:MIR.TX                              :  1
  #   odpt.Railway:Yurikamome.Yurikamome               :  1
  #   odpt.Railway:TWR.Rinkai                          :  1
  attr_reader :index

# @!group 鉄道事業者に関するメソッド

  # @return [::TokyoMetro::StaticDatas::Operator] 鉄道事業者
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.operator.class.name }
  #   =>
  #   TokyoMetro::StaticDatas::Operator::Info
  #   TokyoMetro::StaticDatas::Operator::Info
  #   ......
  #   TokyoMetro::StaticDatas::Operator::Info
  attr_reader :operator

# @!group 鉄道事業者の名称に関するメソッド (1) - 正式名称

  # 鉄道事業者の名称（日本語、正式名称）
  # @return [String or ::Array]
  def operator_name
    @operator.name
  end

  # 鉄道事業者の名称（ローマ字表記、正式名称）
  # @return [String or ::Array]
  def operator_name_en
    @operator.name_en
  end

# @!group 鉄道事業者の名称に関するメソッド (2) - 略称・表示用

  # 鉄道事業者の名称（日本語、略称・表示用）
  # @return [String or nil]
  def operator_name_ja_display
    @operator.name_ja_display
  end

  # 鉄道事業者の名称（ローマ字表記、略称・表示用）
  # @return [String or nil]
  def operator_name_en_display
    @operator.name_en_display
  end

# @!group 鉄道事業者の名称に関するメソッド (3) - 標準の名称（詳細版）

  # 鉄道事業者の標準の名称（日本語・詳細版）
  # @return [String]
  def operator_name_ja_normal_precise
    @operator.name_ja_normal_precise
  end

  # 鉄道事業者の標準の名称（ローマ字表記・詳細版）
  # @return [String]
  def operator_name_en_normal_precise
    @operator.name_en_normal_precise
  end

# @!group 鉄道事業者の名称に関するメソッド (4) - 標準の名称（簡易版）

  # 標準の名称（日本語・簡易版）
  # @return [String]
  def operator_name_ja_normal
    @operator.name_ja_normal
  end

  # 標準の名称（ローマ字表記）
  # @return [String]
  def operator_name_en_normal
    @operator.name_en_normal
  end

# @!group 鉄道事業者の番号

  # 鉄道事業者の番号（整列のための定義）
  # @return [String]
  def operator_order
    @operator.order
  end

  attr_reader :name_hira

# @!group 路線名に関するメソッド (1) - 路線名のみ・正式名称

  # @return [String or ::Array] 路線の名称（日本語・路線名のみ・正式名称） - 路線名（インスタンス変数 name）が定義されている場合
  # @return [nil] nil - 路線名（インスタンス変数 name）が定義されていない場合
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.name_ja }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : 銀座線
  #   odpt.Railway:TokyoMetro.Marunouchi               : 丸ノ内線
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : 丸ノ内線（中野坂上 - 方南町）
  #   odpt.Railway:TokyoMetro.Hibiya                   : 日比谷線
  #   odpt.Railway:TokyoMetro.Tozai                    : 東西線
  #   odpt.Railway:TokyoMetro.Chiyoda                  : 千代田線
  #   odpt.Railway:TokyoMetro.Yurakucho                : 有楽町線
  #   odpt.Railway:TokyoMetro.Hanzomon                 : 半蔵門線
  #   odpt.Railway:TokyoMetro.Namboku                  : 南北線
  #   odpt.Railway:TokyoMetro.Fukutoshin               : 副都心線
  #   odpt.Railway:Toei.Asakusa                        : 浅草線
  #   odpt.Railway:Toei.Mita                           : 三田線
  #   odpt.Railway:Toei.Shinjuku                       : 新宿線
  #   odpt.Railway:Toei.Oedo                           : 大江戸線
  #   odpt.Railway:Toei.NipporiToneri                  : 日暮里・舎人ライナー
  #   odpt.Railway:Toei.TodenArakawa                   : 荒川線
  #   odpt.Railway:JR-East.Yamanote                    : 山手線
  #   odpt.Railway:JR-East.KeihinTohoku                : 京浜東北線
  #   odpt.Railway:JR-East.Tokaido                     : 東海道線
  #   odpt.Railway:JR-East.Yokosuka                    : 横須賀線
  #   odpt.Railway:JR-East.Takasaki                    : 高崎線
  #   odpt.Railway:JR-East.Utsunomiya                  : 宇都宮線
  #   odpt.Railway:JR-East.ShonanShinjuku              : 湘南新宿ライン
  #   odpt.Railway:JR-East.UenoTokyo                   : 上野東京ライン
  #   odpt.Railway:JR-East.Chuo                        : 中央本線
  #   odpt.Railway:JR-East.ChuoKaisoku                 : 中央快速線
  #   odpt.Railway:JR-East.ChuoSobu                    : 中央・総武線 各駅停車
  #   odpt.Railway:JR-East.Sobu                        : 総武本線
  #   odpt.Railway:JR-East.NaritaExpress               : 成田エクスプレス
  #   odpt.Railway:JR-East.Saikyo                      : 埼京線
  #   odpt.Railway:JR-East.Joban                       : 常磐線
  #   odpt.Railway:JR-East.Keiyo                       : 京葉線
  #   odpt.Railway:JR-East.Musashino                   : 武蔵野線
  #   odpt.Railway:JR-East.Shinkansen                  : 東北・秋田・山形・上越・長野新幹線
  #   odpt.Railway:JR-Central.Shinkansen               : 東海道・山陽新幹線
  #   odpt.Railway:Tokyu.Toyoko                        : 東横線
  #   odpt.Railway:Tokyu.Meguro                        : 目黒線
  #   odpt.Railway:Tokyu.DenEnToshi                    : 田園都市線
  #   odpt.Railway:Odakyu.Odawara                      : 小田原線
  #   odpt.Railway:Odakyu.Tama                         : 多摩線
  #   odpt.Railway:Odakyu.Enoshima                     : 江ノ島線
  #   odpt.Railway:Seibu.Ikebukuro                     : 池袋線
  #   odpt.Railway:Seibu.SeibuYurakucho                : 西武有楽町線
  #   odpt.Railway:Seibu.Sayama                        : 狭山線
  #   odpt.Railway:Seibu.Shinjuku                      : 新宿線
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : ["スカイツリーライン（伊勢崎線）", "伊勢崎線"]
  #   odpt.Railway:Tobu.Skytree                        : スカイツリーライン
  #   odpt.Railway:Tobu.Isesaki                        : 伊勢崎線
  #   odpt.Railway:Tobu.Nikko                          : 日光線
  #   odpt.Railway:Tobu.Tojo                           : 東上線
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : (nil)
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : (nil)
  #   odpt.Railway:Keio.Keio                           : 京王線
  #   odpt.Railway:Keio.New                            : 新線
  #   odpt.Railway:Keio.Inokashira                     : 井の頭線
  #   odpt.Railway:Keisei.KeiseiMain                   : 本線
  #   odpt.Railway:Keisei.KeiseiOshiage                : 押上線
  #   odpt.Railway:MIR.TX                              : (nil)
  #   odpt.Railway:Yurikamome.Yurikamome               : (nil)
  #   odpt.Railway:TWR.Rinkai                          : (nil)
  attr_reader :name_ja

  # @return [String or ::Array] 路線の名称（ローマ字表記・路線名のみ・正式名称） - 路線名（インスタンス変数 name_en）が定義されている場合
  # @return [nil] nil - 路線名（インスタンス変数 name）が定義されていない場合
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.name_en }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : Ginza Line
  #   odpt.Railway:TokyoMetro.Marunouchi               : Marunouchi Line
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : Marunouchi Line (Nakano-sakaue - Honancho)
  #   odpt.Railway:TokyoMetro.Hibiya                   : Hibiya Line
  #   odpt.Railway:TokyoMetro.Tozai                    : Tozai Line
  #   odpt.Railway:TokyoMetro.Chiyoda                  : Chiyoda Line
  #   odpt.Railway:TokyoMetro.Yurakucho                : Yurakucho Line
  #   odpt.Railway:TokyoMetro.Hanzomon                 : Hanzomon Line
  #   odpt.Railway:TokyoMetro.Namboku                  : Namboku Line
  #   odpt.Railway:TokyoMetro.Fukutoshin               : Fukutoshin Line
  #   odpt.Railway:Toei.Asakusa                        : Asakusa Line
  #   odpt.Railway:Toei.Mita                           : Mita Line
  #   odpt.Railway:Toei.Shinjuku                       : Shinjuku Line
  #   odpt.Railway:Toei.Oedo                           : Oedo Line
  #   odpt.Railway:Toei.NipporiToneri                  : Nippori Toneri Liner
  #   odpt.Railway:Toei.TodenArakawa                   : Arakawa Line
  #   odpt.Railway:JR-East.Yamanote                    : Yamanote Line
  #   odpt.Railway:JR-East.KeihinTohoku                : Keihin-Tohoku Line
  #   odpt.Railway:JR-East.Tokaido                     : Tokaido Line
  #   odpt.Railway:JR-East.Yokosuka                    : Yokosuka Line
  #   odpt.Railway:JR-East.Takasaki                    : Takasaki Line
  #   odpt.Railway:JR-East.Utsunomiya                  : Utsunomiya Line
  #   odpt.Railway:JR-East.ShonanShinjuku              : Shonan-Shinjuku Line
  #   odpt.Railway:JR-East.UenoTokyo                   : Ueno-Tokyo Line
  #   odpt.Railway:JR-East.Chuo                        : Chuo Line
  #   odpt.Railway:JR-East.ChuoKaisoku                 : Chuo Rapid Line
  #   odpt.Railway:JR-East.ChuoSobu                    : Chuo and Sobu Line (Local)
  #   odpt.Railway:JR-East.Sobu                        : Sobu Line
  #   odpt.Railway:JR-East.NaritaExpress               : Narita Express
  #   odpt.Railway:JR-East.Saikyo                      : Saikyo Line
  #   odpt.Railway:JR-East.Joban                       : Joban Line
  #   odpt.Railway:JR-East.Keiyo                       : Keiyo Line
  #   odpt.Railway:JR-East.Musashino                   : Musashino Line
  #   odpt.Railway:JR-East.Shinkansen                  : Tohoku, Akita, Yamagata, Joetsu and Nagano Shinkansen
  #   odpt.Railway:JR-Central.Shinkansen               : Tokaido and Sanyo Shinkansen
  #   odpt.Railway:Tokyu.Toyoko                        : Toyoko Line
  #   odpt.Railway:Tokyu.Meguro                        : Meguro Line
  #   odpt.Railway:Tokyu.DenEnToshi                    : Den-en-toshi Line
  #   odpt.Railway:Odakyu.Odawara                      : Odawara Line
  #   odpt.Railway:Odakyu.Tama                         : Tama Line
  #   odpt.Railway:Odakyu.Enoshima                     : Enoshima Line
  #   odpt.Railway:Seibu.Ikebukuro                     : Ikebukuro Line
  #   odpt.Railway:Seibu.SeibuYurakucho                : Seibu Yurakucho Line
  #   odpt.Railway:Seibu.Sayama                        : Sayama Line
  #   odpt.Railway:Seibu.Shinjuku                      : Shinjuku Line
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : Sky Tree and Isesaki Line
  #   odpt.Railway:Tobu.Skytree                        : Sky Tree Line
  #   odpt.Railway:Tobu.Isesaki                        : Isesaki Line
  #   odpt.Railway:Tobu.Nikko                          : Nikko Line
  #   odpt.Railway:Tobu.Tojo                           : Tojo Line
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : (nil)
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : (nil)
  #   odpt.Railway:Keio.Keio                           : Keio Line
  #   odpt.Railway:Keio.New                            : New Line
  #   odpt.Railway:Keio.Inokashira                     : Inokashira Line
  #   odpt.Railway:Keisei.KeiseiMain                   : Main Line
  #   odpt.Railway:Keisei.KeiseiOshiage                : Oshiage Line
  #   odpt.Railway:MIR.TX                              : (nil)
  #   odpt.Railway:Yurikamome.Yurikamome               : (nil)
  #   odpt.Railway:TWR.Rinkai                          : (nil)
  attr_reader :name_en

# @!group 路線名に関するメソッド (2) - 標準（路線名のみ）

  # 路線名（標準・日本語表記・路線名のみ）を取得するメソッド
  # @return [String] 路線名（インスタンス変数 name）が定義されている場合
  # @return [nil] 路線名（インスタンス変数 name）が定義されていない場合
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.name_ja_normal }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : 銀座線
  #   odpt.Railway:TokyoMetro.Marunouchi               : 丸ノ内線
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : 丸ノ内線（中野坂上 - 方南町）
  #   odpt.Railway:TokyoMetro.Hibiya                   : 日比谷線
  #   odpt.Railway:TokyoMetro.Tozai                    : 東西線
  #   odpt.Railway:TokyoMetro.Chiyoda                  : 千代田線
  #   odpt.Railway:TokyoMetro.Yurakucho                : 有楽町線
  #   odpt.Railway:TokyoMetro.Hanzomon                 : 半蔵門線
  #   odpt.Railway:TokyoMetro.Namboku                  : 南北線
  #   odpt.Railway:TokyoMetro.Fukutoshin               : 副都心線
  #   odpt.Railway:Toei.Asakusa                        : 浅草線
  #   odpt.Railway:Toei.Mita                           : 三田線
  #   odpt.Railway:Toei.Shinjuku                       : 新宿線
  #   odpt.Railway:Toei.Oedo                           : 大江戸線
  #   odpt.Railway:Toei.NipporiToneri                  : 日暮里・舎人ライナー
  #   odpt.Railway:Toei.TodenArakawa                   : 荒川線
  #   odpt.Railway:JR-East.Yamanote                    : 山手線
  #   odpt.Railway:JR-East.KeihinTohoku                : 京浜東北線
  #   odpt.Railway:JR-East.Tokaido                     : 東海道線
  #   odpt.Railway:JR-East.Yokosuka                    : 横須賀線
  #   odpt.Railway:JR-East.Takasaki                    : 高崎線
  #   odpt.Railway:JR-East.Utsunomiya                  : 宇都宮線
  #   odpt.Railway:JR-East.ShonanShinjuku              : 湘南新宿ライン
  #   odpt.Railway:JR-East.UenoTokyo                   : 上野東京ライン
  #   odpt.Railway:JR-East.Chuo                        : 中央本線
  #   odpt.Railway:JR-East.ChuoKaisoku                 : 中央快速線
  #   odpt.Railway:JR-East.ChuoSobu                    : 中央・総武線 各駅停車
  #   odpt.Railway:JR-East.Sobu                        : 総武本線
  #   odpt.Railway:JR-East.NaritaExpress               : 成田エクスプレス
  #   odpt.Railway:JR-East.Saikyo                      : 埼京線
  #   odpt.Railway:JR-East.Joban                       : 常磐線
  #   odpt.Railway:JR-East.Keiyo                       : 京葉線
  #   odpt.Railway:JR-East.Musashino                   : 武蔵野線
  #   odpt.Railway:JR-East.Shinkansen                  : 東北・秋田・山形・上越・長野新幹線
  #   odpt.Railway:JR-Central.Shinkansen               : 東海道・山陽新幹線
  #   odpt.Railway:Tokyu.Toyoko                        : 東横線
  #   odpt.Railway:Tokyu.Meguro                        : 目黒線
  #   odpt.Railway:Tokyu.DenEnToshi                    : 田園都市線
  #   odpt.Railway:Odakyu.Odawara                      : 小田原線
  #   odpt.Railway:Odakyu.Tama                         : 多摩線
  #   odpt.Railway:Odakyu.Enoshima                     : 江ノ島線
  #   odpt.Railway:Seibu.Ikebukuro                     : 池袋線
  #   odpt.Railway:Seibu.SeibuYurakucho                : 西武有楽町線
  #   odpt.Railway:Seibu.Sayama                        : 狭山線
  #   odpt.Railway:Seibu.Shinjuku                      : 新宿線
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : スカイツリーライン（伊勢崎線）
  #   odpt.Railway:Tobu.Skytree                        : スカイツリーライン
  #   odpt.Railway:Tobu.Isesaki                        : 伊勢崎線
  #   odpt.Railway:Tobu.Nikko                          : 日光線
  #   odpt.Railway:Tobu.Tojo                           : 東上線
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : (nil)
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : (nil)
  #   odpt.Railway:Keio.Keio                           : 京王線
  #   odpt.Railway:Keio.New                            : 新線
  #   odpt.Railway:Keio.Inokashira                     : 井の頭線
  #   odpt.Railway:Keisei.KeiseiMain                   : 本線
  #   odpt.Railway:Keisei.KeiseiOshiage                : 押上線
  #   odpt.Railway:MIR.TX                              : (nil)
  #   odpt.Railway:Yurikamome.Yurikamome               : (nil)
  #   odpt.Railway:TWR.Rinkai                          : (nil)
  def name_ja_normal
    get_name( @name_ja , allow_nil: true )
  end

  # 路線名（標準・ローマ字表記・路線名のみ）を取得するメソッド
  # @return [String] 路線名（インスタンス変数 name_en）が定義されている場合
  # @return [nil] 路線名（インスタンス変数 name_en）が定義されていない場合
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.name_en_normal }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : Ginza Line
  #   odpt.Railway:TokyoMetro.Marunouchi               : Marunouchi Line
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : Marunouchi Line (Nakano-sakaue - Honancho)
  #   odpt.Railway:TokyoMetro.Hibiya                   : Hibiya Line
  #   odpt.Railway:TokyoMetro.Tozai                    : Tozai Line
  #   odpt.Railway:TokyoMetro.Chiyoda                  : Chiyoda Line
  #   odpt.Railway:TokyoMetro.Yurakucho                : Yurakucho Line
  #   odpt.Railway:TokyoMetro.Hanzomon                 : Hanzomon Line
  #   odpt.Railway:TokyoMetro.Namboku                  : Namboku Line
  #   odpt.Railway:TokyoMetro.Fukutoshin               : Fukutoshin Line
  #   odpt.Railway:Toei.Asakusa                        : Asakusa Line
  #   odpt.Railway:Toei.Mita                           : Mita Line
  #   odpt.Railway:Toei.Shinjuku                       : Shinjuku Line
  #   odpt.Railway:Toei.Oedo                           : Oedo Line
  #   odpt.Railway:Toei.NipporiToneri                  : Nippori Toneri Liner
  #   odpt.Railway:Toei.TodenArakawa                   : Arakawa Line
  #   odpt.Railway:JR-East.Yamanote                    : Yamanote Line
  #   odpt.Railway:JR-East.KeihinTohoku                : Keihin-Tohoku Line
  #   odpt.Railway:JR-East.Tokaido                     : Tokaido Line
  #   odpt.Railway:JR-East.Yokosuka                    : Yokosuka Line
  #   odpt.Railway:JR-East.Takasaki                    : Takasaki Line
  #   odpt.Railway:JR-East.Utsunomiya                  : Utsunomiya Line
  #   odpt.Railway:JR-East.ShonanShinjuku              : Shonan-Shinjuku Line
  #   odpt.Railway:JR-East.UenoTokyo                   : Ueno-Tokyo Line
  #   odpt.Railway:JR-East.Chuo                        : Chuo Line
  #   odpt.Railway:JR-East.ChuoKaisoku                 : Chuo Rapid Line
  #   odpt.Railway:JR-East.ChuoSobu                    : Chuo and Sobu Line (Local)
  #   odpt.Railway:JR-East.Sobu                        : Sobu Line
  #   odpt.Railway:JR-East.NaritaExpress               : Narita Express
  #   odpt.Railway:JR-East.Saikyo                      : Saikyo Line
  #   odpt.Railway:JR-East.Joban                       : Joban Line
  #   odpt.Railway:JR-East.Keiyo                       : Keiyo Line
  #   odpt.Railway:JR-East.Musashino                   : Musashino Line
  #   odpt.Railway:JR-East.Shinkansen                  : Tohoku, Akita, Yamagata, Joetsu and Nagano Shinkansen
  #   odpt.Railway:JR-Central.Shinkansen               : Tokaido and Sanyo Shinkansen
  #   odpt.Railway:Tokyu.Toyoko                        : Toyoko Line
  #   odpt.Railway:Tokyu.Meguro                        : Meguro Line
  #   odpt.Railway:Tokyu.DenEnToshi                    : Den-en-toshi Line
  #   odpt.Railway:Odakyu.Odawara                      : Odawara Line
  #   odpt.Railway:Odakyu.Tama                         : Tama Line
  #   odpt.Railway:Odakyu.Enoshima                     : Enoshima Line
  #   odpt.Railway:Seibu.Ikebukuro                     : Ikebukuro Line
  #   odpt.Railway:Seibu.SeibuYurakucho                : Seibu Yurakucho Line
  #   odpt.Railway:Seibu.Sayama                        : Sayama Line
  #   odpt.Railway:Seibu.Shinjuku                      : Shinjuku Line
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : Sky Tree and Isesaki Line
  #   odpt.Railway:Tobu.Skytree                        : Sky Tree Line
  #   odpt.Railway:Tobu.Isesaki                        : Isesaki Line
  #   odpt.Railway:Tobu.Nikko                          : Nikko Line
  #   odpt.Railway:Tobu.Tojo                           : Tojo Line
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : (nil)
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : (nil)
  #   odpt.Railway:Keio.Keio                           : Keio Line
  #   odpt.Railway:Keio.New                            : New Line
  #   odpt.Railway:Keio.Inokashira                     : Inokashira Line
  #   odpt.Railway:Keisei.KeiseiMain                   : Main Line
  #   odpt.Railway:Keisei.KeiseiOshiage                : Oshiage Line
  #   odpt.Railway:MIR.TX                              : (nil)
  #   odpt.Railway:Yurikamome.Yurikamome               : (nil)
  #   odpt.Railway:TWR.Rinkai                          : (nil)
  def name_en_normal
    get_name( @name_en , allow_nil: true )
  end

# @!group 路線名に関するメソッド (3) - 表示用（事業者名 + 路線名）

  # 路線名（標準・日本語表記・事業者名あり）を取得するメソッド
  # @return [String]
  # @note 日暮里・舎人ライナーについては、先頭に「都営」を付けない。
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.name_ja_with_operator_name_precise }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : 東京メトロ銀座線
  #   odpt.Railway:TokyoMetro.Marunouchi               : 東京メトロ丸ノ内線
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : 東京メトロ丸ノ内線（中野坂上 - 方南町）
  #   odpt.Railway:TokyoMetro.Hibiya                   : 東京メトロ日比谷線
  #   odpt.Railway:TokyoMetro.Tozai                    : 東京メトロ東西線
  #   odpt.Railway:TokyoMetro.Chiyoda                  : 東京メトロ千代田線
  #   odpt.Railway:TokyoMetro.Yurakucho                : 東京メトロ有楽町線
  #   odpt.Railway:TokyoMetro.Hanzomon                 : 東京メトロ半蔵門線
  #   odpt.Railway:TokyoMetro.Namboku                  : 東京メトロ南北線
  #   odpt.Railway:TokyoMetro.Fukutoshin               : 東京メトロ副都心線
  #   odpt.Railway:Toei.Asakusa                        : 都営浅草線
  #   odpt.Railway:Toei.Mita                           : 都営三田線
  #   odpt.Railway:Toei.Shinjuku                       : 都営新宿線
  #   odpt.Railway:Toei.Oedo                           : 都営大江戸線
  #   odpt.Railway:Toei.NipporiToneri                  : 日暮里・舎人ライナー
  #   odpt.Railway:Toei.TodenArakawa                   : 都電荒川線
  #   odpt.Railway:JR-East.Yamanote                    : JR山手線
  #   odpt.Railway:JR-East.KeihinTohoku                : JR京浜東北線
  #   odpt.Railway:JR-East.Tokaido                     : JR東海道線
  #   odpt.Railway:JR-East.Yokosuka                    : JR横須賀線
  #   odpt.Railway:JR-East.Takasaki                    : JR高崎線
  #   odpt.Railway:JR-East.Utsunomiya                  : JR宇都宮線
  #   odpt.Railway:JR-East.ShonanShinjuku              : JR湘南新宿ライン
  #   odpt.Railway:JR-East.UenoTokyo                   : JR上野東京ライン
  #   odpt.Railway:JR-East.Chuo                        : JR中央本線
  #   odpt.Railway:JR-East.ChuoKaisoku                 : JR中央快速線
  #   odpt.Railway:JR-East.ChuoSobu                    : JR中央・総武線 各駅停車
  #   odpt.Railway:JR-East.Sobu                        : JR総武本線
  #   odpt.Railway:JR-East.NaritaExpress               : JR成田エクスプレス
  #   odpt.Railway:JR-East.Saikyo                      : JR埼京線
  #   odpt.Railway:JR-East.Joban                       : JR常磐線
  #   odpt.Railway:JR-East.Keiyo                       : JR京葉線
  #   odpt.Railway:JR-East.Musashino                   : JR武蔵野線
  #   odpt.Railway:JR-East.Shinkansen                  : JR東北・秋田・山形・上越・長野新幹線
  #   odpt.Railway:JR-Central.Shinkansen               : JR東海道・山陽新幹線
  #   odpt.Railway:Tokyu.Toyoko                        : 東急東横線
  #   odpt.Railway:Tokyu.Meguro                        : 東急目黒線
  #   odpt.Railway:Tokyu.DenEnToshi                    : 東急田園都市線
  #   odpt.Railway:Odakyu.Odawara                      : 小田急小田原線
  #   odpt.Railway:Odakyu.Tama                         : 小田急多摩線
  #   odpt.Railway:Odakyu.Enoshima                     : 小田急江ノ島線
  #   odpt.Railway:Seibu.Ikebukuro                     : 西武池袋線
  #   odpt.Railway:Seibu.SeibuYurakucho                : 西武有楽町線
  #   odpt.Railway:Seibu.Sayama                        : 西武狭山線
  #   odpt.Railway:Seibu.Shinjuku                      : 西武新宿線
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : 東武スカイツリーライン（伊勢崎線）
  #   odpt.Railway:Tobu.Skytree                        : 東武スカイツリーライン
  #   odpt.Railway:Tobu.Isesaki                        : 東武伊勢崎線
  #   odpt.Railway:Tobu.Nikko                          : 東武日光線
  #   odpt.Railway:Tobu.Tojo                           : 東武東上線
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : 埼玉高速鉄道
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : 東葉高速鉄道
  #   odpt.Railway:Keio.Keio                           : 京王線
  #   odpt.Railway:Keio.New                            : 京王新線
  #   odpt.Railway:Keio.Inokashira                     : 京王井の頭線
  #   odpt.Railway:Keisei.KeiseiMain                   : 京成本線
  #   odpt.Railway:Keisei.KeiseiOshiage                : 京成押上線
  #   odpt.Railway:MIR.TX                              : つくばエクスプレス
  #   odpt.Railway:Yurikamome.Yurikamome               : ゆりかもめ
  #   odpt.Railway:TWR.Rinkai                          : りんかい線
  def name_ja_with_operator_name_precise
    # 標準の事業者名
    operator_name_ja_normal_str = self.operator_name_ja_normal
    # 標準の路線名（路線名のみ）
    name_ja_normal_str = self.name_ja_normal

    str = set_name_ja_display( operator_name_ja_normal_str , name_ja_normal_str , en: false )

    if str.string?
      return str
    else
      puts "Error:"
      puts "  \[\name_ja_normal\] #{name_ja_normal_str} (class: #{name_ja_normal_str.class.name})"
      puts "  \[operator_name_ja_normal\] #{operator_name_ja_normal} (class: #{operator_name_ja_normal.class.name})"
      raise "Error"
    end
  end

  # 路線名（標準・ローマ字表記・事業者名あり）を取得するメソッド
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.name_en_with_operator_name_precise }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : Tokyo Metro Ginza Line
  #   odpt.Railway:TokyoMetro.Marunouchi               : Tokyo Metro Marunouchi Line
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : Tokyo Metro Marunouchi Line (Nakano-sakaue - Honancho)
  #   odpt.Railway:TokyoMetro.Hibiya                   : Tokyo Metro Hibiya Line
  #   odpt.Railway:TokyoMetro.Tozai                    : Tokyo Metro Tozai Line
  #   odpt.Railway:TokyoMetro.Chiyoda                  : Tokyo Metro Chiyoda Line
  #   odpt.Railway:TokyoMetro.Yurakucho                : Tokyo Metro Yurakucho Line
  #   odpt.Railway:TokyoMetro.Hanzomon                 : Tokyo Metro Hanzomon Line
  #   odpt.Railway:TokyoMetro.Namboku                  : Tokyo Metro Namboku Line
  #   odpt.Railway:TokyoMetro.Fukutoshin               : Tokyo Metro Fukutoshin Line
  #   odpt.Railway:Toei.Asakusa                        : Toei Asakusa Line
  #   odpt.Railway:Toei.Mita                           : Toei Mita Line
  #   odpt.Railway:Toei.Shinjuku                       : Toei Shinjuku Line
  #   odpt.Railway:Toei.Oedo                           : Toei Oedo Line
  #   odpt.Railway:Toei.NipporiToneri                  : Nippori Toneri Liner
  #   odpt.Railway:Toei.TodenArakawa                   : Toden Arakawa Line
  #   odpt.Railway:JR-East.Yamanote                    : JR Yamanote Line
  #   odpt.Railway:JR-East.KeihinTohoku                : JR Keihin-Tohoku Line
  #   odpt.Railway:JR-East.Tokaido                     : JR Tokaido Line
  #   odpt.Railway:JR-East.Yokosuka                    : JR Yokosuka Line
  #   odpt.Railway:JR-East.Takasaki                    : JR Takasaki Line
  #   odpt.Railway:JR-East.Utsunomiya                  : JR Utsunomiya Line
  #   odpt.Railway:JR-East.ShonanShinjuku              : JR Shonan-Shinjuku Line
  #   odpt.Railway:JR-East.UenoTokyo                   : JR Ueno-Tokyo Line
  #   odpt.Railway:JR-East.Chuo                        : JR Chuo Line
  #   odpt.Railway:JR-East.ChuoKaisoku                 : JR Chuo Rapid Line
  #   odpt.Railway:JR-East.ChuoSobu                    : JR Chuo and Sobu Line (Local)
  #   odpt.Railway:JR-East.Sobu                        : JR Sobu Line
  #   odpt.Railway:JR-East.NaritaExpress               : JR Narita Express
  #   odpt.Railway:JR-East.Saikyo                      : JR Saikyo Line
  #   odpt.Railway:JR-East.Joban                       : JR Joban Line
  #   odpt.Railway:JR-East.Keiyo                       : JR Keiyo Line
  #   odpt.Railway:JR-East.Musashino                   : JR Musashino Line
  #   odpt.Railway:JR-East.Shinkansen                  : Tohoku, Akita, Yamagata, Joetsu and Nagano Shinkansen
  #   odpt.Railway:JR-Central.Shinkansen               : Tokaido and Sanyo Shinkansen
  #   odpt.Railway:Tokyu.Toyoko                        : Tokyu Toyoko Line
  #   odpt.Railway:Tokyu.Meguro                        : Tokyu Meguro Line
  #   odpt.Railway:Tokyu.DenEnToshi                    : Tokyu Den-en-toshi Line
  #   odpt.Railway:Odakyu.Odawara                      : Odakyu Odawara Line
  #   odpt.Railway:Odakyu.Tama                         : Odakyu Tama Line
  #   odpt.Railway:Odakyu.Enoshima                     : Odakyu Enoshima Line
  #   odpt.Railway:Seibu.Ikebukuro                     : Seibu Ikebukuro Line
  #   odpt.Railway:Seibu.SeibuYurakucho                : Seibu Yurakucho Line
  #   odpt.Railway:Seibu.Sayama                        : Seibu Sayama Line
  #   odpt.Railway:Seibu.Shinjuku                      : Seibu Shinjuku Line
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : Tobu Sky Tree and Isesaki Line
  #   odpt.Railway:Tobu.Skytree                        : Tobu Sky Tree Line
  #   odpt.Railway:Tobu.Isesaki                        : Tobu Isesaki Line
  #   odpt.Railway:Tobu.Nikko                          : Tobu Nikko Line
  #   odpt.Railway:Tobu.Tojo                           : Tobu Tojo Line
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : Saitama Railway
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : Toyo Rapid Railway
  #   odpt.Railway:Keio.Keio                           : Keio Line
  #   odpt.Railway:Keio.New                            : Keio New Line
  #   odpt.Railway:Keio.Inokashira                     : Keio Inokashira Line
  #   odpt.Railway:Keisei.KeiseiMain                   : Keisei Main Line
  #   odpt.Railway:Keisei.KeiseiOshiage                : Keisei Oshiage Line
  #   odpt.Railway:MIR.TX                              : Tsukuba Express
  #   odpt.Railway:Yurikamome.Yurikamome               : Yurikamome
  #   odpt.Railway:TWR.Rinkai                          : Rinkai Line
  def name_en_with_operator_name_precise
    # 標準の事業者名
    operator_name_ja_normal_str = self.operator_name_en_normal
    # 標準の路線名（路線名のみ）
    name_ja_normal_str = self.name_en_normal

    str = set_name_ja_display( operator_name_ja_normal_str , name_ja_normal_str , en: true )

    if str.string?
      return str
    else
      puts "Error:"
      puts "  \[\name_ja_normal\] #{name_ja_normal_str} (class: #{name_ja_normal_str.class.name})"
      puts "  \[operator_name_en_normal_str\] #{operator_name_en_normal_str} (class: #{operator_name_en_normal_str.class.name})"
      raise "Error"
    end
  end

# @!group 路線名に関するメソッド (4) - 標準（【原則】事業者名 + 路線名）

  # 路線名（標準・日本語表記・【原則】事業者名あり）を取得するメソッド
  # @note 事業者名が「東京メトロ」の場合は事業者名を省略する。
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.name_ja_with_operator_name }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : 銀座線
  #   odpt.Railway:TokyoMetro.Marunouchi               : 丸ノ内線
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : 丸ノ内線（中野坂上 - 方南町）
  #   odpt.Railway:TokyoMetro.Hibiya                   : 日比谷線
  #   odpt.Railway:TokyoMetro.Tozai                    : 東西線
  #   odpt.Railway:TokyoMetro.Chiyoda                  : 千代田線
  #   odpt.Railway:TokyoMetro.Yurakucho                : 有楽町線
  #   odpt.Railway:TokyoMetro.Hanzomon                 : 半蔵門線
  #   odpt.Railway:TokyoMetro.Namboku                  : 南北線
  #   odpt.Railway:TokyoMetro.Fukutoshin               : 副都心線
  #   odpt.Railway:Toei.Asakusa                        : 都営浅草線
  #   odpt.Railway:Toei.Mita                           : 都営三田線
  #   odpt.Railway:Toei.Shinjuku                       : 都営新宿線
  #   odpt.Railway:Toei.Oedo                           : 都営大江戸線
  #   odpt.Railway:Toei.NipporiToneri                  : 日暮里・舎人ライナー
  #   odpt.Railway:Toei.TodenArakawa                   : 都電荒川線
  #   odpt.Railway:JR-East.Yamanote                    : JR山手線
  #   odpt.Railway:JR-East.KeihinTohoku                : JR京浜東北線
  #   odpt.Railway:JR-East.Tokaido                     : JR東海道線
  #   odpt.Railway:JR-East.Yokosuka                    : JR横須賀線
  #   odpt.Railway:JR-East.Takasaki                    : JR高崎線
  #   odpt.Railway:JR-East.Utsunomiya                  : JR宇都宮線
  #   odpt.Railway:JR-East.ShonanShinjuku              : JR湘南新宿ライン
  #   odpt.Railway:JR-East.UenoTokyo                   : JR上野東京ライン
  #   odpt.Railway:JR-East.Chuo                        : JR中央本線
  #   odpt.Railway:JR-East.ChuoKaisoku                 : JR中央快速線
  #   odpt.Railway:JR-East.ChuoSobu                    : JR中央・総武線 各駅停車
  #   odpt.Railway:JR-East.Sobu                        : JR総武本線
  #   odpt.Railway:JR-East.NaritaExpress               : JR成田エクスプレス
  #   odpt.Railway:JR-East.Saikyo                      : JR埼京線
  #   odpt.Railway:JR-East.Joban                       : JR常磐線
  #   odpt.Railway:JR-East.Keiyo                       : JR京葉線
  #   odpt.Railway:JR-East.Musashino                   : JR武蔵野線
  #   odpt.Railway:JR-East.Shinkansen                  : 東北・秋田・山形・上越・長野新幹線
  #   odpt.Railway:JR-Central.Shinkansen               : 東海道・山陽新幹線
  #   odpt.Railway:Tokyu.Toyoko                        : 東急東横線
  #   odpt.Railway:Tokyu.Meguro                        : 東急目黒線
  #   odpt.Railway:Tokyu.DenEnToshi                    : 東急田園都市線
  #   odpt.Railway:Odakyu.Odawara                      : 小田急小田原線
  #   odpt.Railway:Odakyu.Tama                         : 小田急多摩線
  #   odpt.Railway:Odakyu.Enoshima                     : 小田急江ノ島線
  #   odpt.Railway:Seibu.Ikebukuro                     : 西武池袋線
  #   odpt.Railway:Seibu.SeibuYurakucho                : 西武有楽町線
  #   odpt.Railway:Seibu.Sayama                        : 西武狭山線
  #   odpt.Railway:Seibu.Shinjuku                      : 西武新宿線
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : 東武スカイツリーライン（伊勢崎線）
  #   odpt.Railway:Tobu.Skytree                        : 東武スカイツリーライン
  #   odpt.Railway:Tobu.Isesaki                        : 東武伊勢崎線
  #   odpt.Railway:Tobu.Nikko                          : 東武日光線
  #   odpt.Railway:Tobu.Tojo                           : 東武東上線
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : 埼玉高速鉄道
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : 東葉高速鉄道
  #   odpt.Railway:Keio.Keio                           : 京王線
  #   odpt.Railway:Keio.New                            : 京王新線
  #   odpt.Railway:Keio.Inokashira                     : 京王井の頭線
  #   odpt.Railway:Keisei.KeiseiMain                   : 京成本線
  #   odpt.Railway:Keisei.KeiseiOshiage                : 京成押上線
  #   odpt.Railway:MIR.TX                              : つくばエクスプレス
  #   odpt.Railway:Yurikamome.Yurikamome               : ゆりかもめ
  #   odpt.Railway:TWR.Rinkai                          : りんかい線
  def name_ja_with_operator_name
    # 標準の事業者名
    operator_name_ja_normal_str = self.operator_name_ja_normal
    # 標準の路線名（路線名のみ）
    name_ja_normal_str = self.name_ja_normal
    # 事業者名を付けるか否かの設定
    with_operator_setting = name_ja_with_operator_name__set_operator_setting

    set_name_ja_display( operator_name_ja_normal_str , name_ja_normal_str , en: false , with_operator: with_operator_setting )
  end

  # 路線名（標準・ローマ字表記・【原則】事業者名あり）を取得するメソッド
  # @note ローマ字表記の事業者名が "Tokyo Metro" の場合は事業者名を省略する。
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.name_en_with_operator_name }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : Ginza Line
  #   odpt.Railway:TokyoMetro.Marunouchi               : Marunouchi Line
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : Marunouchi Line (Nakano-sakaue - Honancho)
  #   odpt.Railway:TokyoMetro.Hibiya                   : Hibiya Line
  #   odpt.Railway:TokyoMetro.Tozai                    : Tozai Line
  #   odpt.Railway:TokyoMetro.Chiyoda                  : Chiyoda Line
  #   odpt.Railway:TokyoMetro.Yurakucho                : Yurakucho Line
  #   odpt.Railway:TokyoMetro.Hanzomon                 : Hanzomon Line
  #   odpt.Railway:TokyoMetro.Namboku                  : Namboku Line
  #   odpt.Railway:TokyoMetro.Fukutoshin               : Fukutoshin Line
  #   odpt.Railway:Toei.Asakusa                        : Toei Asakusa Line
  #   odpt.Railway:Toei.Mita                           : Toei Mita Line
  #   odpt.Railway:Toei.Shinjuku                       : Toei Shinjuku Line
  #   odpt.Railway:Toei.Oedo                           : Toei Oedo Line
  #   odpt.Railway:Toei.NipporiToneri                  : Nippori Toneri Liner
  #   odpt.Railway:Toei.TodenArakawa                   : Toden Arakawa Line
  #   odpt.Railway:JR-East.Yamanote                    : JR Yamanote Line
  #   odpt.Railway:JR-East.KeihinTohoku                : JR Keihin-Tohoku Line
  #   odpt.Railway:JR-East.Tokaido                     : JR Tokaido Line
  #   odpt.Railway:JR-East.Yokosuka                    : JR Yokosuka Line
  #   odpt.Railway:JR-East.Takasaki                    : JR Takasaki Line
  #   odpt.Railway:JR-East.Utsunomiya                  : JR Utsunomiya Line
  #   odpt.Railway:JR-East.ShonanShinjuku              : JR Shonan-Shinjuku Line
  #   odpt.Railway:JR-East.UenoTokyo                   : JR Ueno-Tokyo Line
  #   odpt.Railway:JR-East.Chuo                        : JR Chuo Line
  #   odpt.Railway:JR-East.ChuoKaisoku                 : JR Chuo Rapid Line
  #   odpt.Railway:JR-East.ChuoSobu                    : JR Chuo and Sobu Line (Local)
  #   odpt.Railway:JR-East.Sobu                        : JR Sobu Line
  #   odpt.Railway:JR-East.NaritaExpress               : JR Narita Express
  #   odpt.Railway:JR-East.Saikyo                      : JR Saikyo Line
  #   odpt.Railway:JR-East.Joban                       : JR Joban Line
  #   odpt.Railway:JR-East.Keiyo                       : JR Keiyo Line
  #   odpt.Railway:JR-East.Musashino                   : JR Musashino Line
  #   odpt.Railway:JR-East.Shinkansen                  : Tohoku, Akita, Yamagata, Joetsu and Nagano Shinkansen
  #   odpt.Railway:JR-Central.Shinkansen               : Tokaido and Sanyo Shinkansen
  #   odpt.Railway:Tokyu.Toyoko                        : Tokyu Toyoko Line
  #   odpt.Railway:Tokyu.Meguro                        : Tokyu Meguro Line
  #   odpt.Railway:Tokyu.DenEnToshi                    : Tokyu Den-en-toshi Line
  #   odpt.Railway:Odakyu.Odawara                      : Odakyu Odawara Line
  #   odpt.Railway:Odakyu.Tama                         : Odakyu Tama Line
  #   odpt.Railway:Odakyu.Enoshima                     : Odakyu Enoshima Line
  #   odpt.Railway:Seibu.Ikebukuro                     : Seibu Ikebukuro Line
  #   odpt.Railway:Seibu.SeibuYurakucho                : Seibu Yurakucho Line
  #   odpt.Railway:Seibu.Sayama                        : Seibu Sayama Line
  #   odpt.Railway:Seibu.Shinjuku                      : Seibu Shinjuku Line
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : Tobu Sky Tree and Isesaki Line
  #   odpt.Railway:Tobu.Skytree                        : Tobu Sky Tree Line
  #   odpt.Railway:Tobu.Isesaki                        : Tobu Isesaki Line
  #   odpt.Railway:Tobu.Nikko                          : Tobu Nikko Line
  #   odpt.Railway:Tobu.Tojo                           : Tobu Tojo Line
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : Saitama Railway
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : Toyo Rapid Railway
  #   odpt.Railway:Keio.Keio                           : Keio Line
  #   odpt.Railway:Keio.New                            : Keio New Line
  #   odpt.Railway:Keio.Inokashira                     : Keio Inokashira Line
  #   odpt.Railway:Keisei.KeiseiMain                   : Keisei Main Line
  #   odpt.Railway:Keisei.KeiseiOshiage                : Keisei Oshiage Line
  #   odpt.Railway:MIR.TX                              : Tsukuba Express
  #   odpt.Railway:Yurikamome.Yurikamome               : Yurikamome
  #   odpt.Railway:TWR.Rinkai                          : Rinkai Line
  def name_en_with_operator_name
    # 標準の事業者名
    operator_name_ja_normal_str = self.operator_name_en_normal
    # 標準の路線名（路線名のみ）
    name_ja_normal_str = self.name_en_normal
    # 事業者名を付けるか否かの設定
    with_operator_setting = name_ja_with_operator_name__set_operator_setting

    set_name_ja_display( operator_name_ja_normal_str , name_ja_normal_str , en: true , with_operator: with_operator_setting )
  end

# @!group 路線色に関するメソッド (1)

  # 標準の路線色を取得するメソッド
  # @return [::TokyoMetro::StaticDatas::Color or ::Array <::TokyoMetro::StaticDatas::Color>] インスタンス変数 color が定義されている場合
  # @return [nil] インスタンス変数 color が定義されていない場合
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.color.class.name }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.Marunouchi               : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.Hibiya                   : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.Tozai                    : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.Chiyoda                  : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.Yurakucho                : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.Hanzomon                 : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.Namboku                  : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.Fukutoshin               : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Toei.Asakusa                        : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Toei.Mita                           : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Toei.Shinjuku                       : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Toei.Oedo                           : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Toei.NipporiToneri                  : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Toei.TodenArakawa                   : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Yamanote                    : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.KeihinTohoku                : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Tokaido                     : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Yokosuka                    : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Takasaki                    : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Utsunomiya                  : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.ShonanShinjuku              : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.UenoTokyo                   : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Chuo                        : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.ChuoKaisoku                 : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.ChuoSobu                    : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Sobu                        : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.NaritaExpress               : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Saikyo                      : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Joban                       : Array
  #   odpt.Railway:JR-East.Keiyo                       : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Musashino                   : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-East.Shinkansen                  : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:JR-Tokai.Shinkansen                 : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Tokyu.Toyoko                        : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Tokyu.Meguro                        : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Tokyu.DenEnToshi                    : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Odakyu.Odawara                      : NilClass
  #   odpt.Railway:Odakyu.Tama                         : NilClass
  #   odpt.Railway:Odakyu.Enoshima                     : NilClass
  #   odpt.Railway:Seibu.Ikebukuro                     : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Seibu.SeibuYurakucho                : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Seibu.Sayama                        : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Seibu.Shinjuku                      : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : Array
  #   odpt.Railway:Tobu.Skytree                        : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Tobu.Isesaki                        : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Tobu.Nikko                          : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Tobu.Tojo                           : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : NilClass
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : NilClass
  #   odpt.Railway:Keio.Keio                           : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Keio.New                            : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Keio.Inokashira                     : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:Keisei.KeiseiMain                   : NilClass
  #   odpt.Railway:Keisei.KeiseiOshiage                : NilClass
  #   odpt.Railway:MIR.TX                              : NilClass
  #   odpt.Railway:Yurikamome.Yurikamome               : NilClass
  #   odpt.Railway:TWR.Rinkai                          : NilClass
  attr_reader :color

  # 標準の路線色を取得するメソッド
  # @return [::TokyoMetro::StaticDatas::Color]
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.color_normal.class.name }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.Marunouchi               : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : TokyoMetro::StaticDatas::Color
  #   ......
  #   odpt.Railway:Yurikamome.Yurikamome               : TokyoMetro::StaticDatas::Color
  #   odpt.Railway:TWR.Rinkai                          : TokyoMetro::StaticDatas::Color
  def color_normal
    # 路線の色が定義されていない場合
    if @color.nil?
      # 事業者の色が定義されている場合は、事業者の色をそのまま標準の路線色とする。
      if self.operator_color.instance_of?( ::TokyoMetro::StaticDatas::Color )
        self.operator_color
      # 事業者の色が定義されていない場合は、#999999 を標準の路線色とする。
      else
        ::TokyoMetro::StaticDatas::Color.new( "\#999999" , 153 , 153 , 153 )
      end
    # 路線の色が複数設定されている場合（@color が配列の場合）は、配列の最初の要素を標準の路線色とする。
    elsif @color.instance_of?( ::Array )
      @color.first
    # 路線の色が1つのみ設定されている場合は、それを標準の路線色とする。
    elsif @color.instance_of?( ::TokyoMetro::StaticDatas::Color )
      @color
    end
  end

  # 標準の路線色の WebColor を取得するメソッド
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.color_normal_web }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : #f39700
  #   odpt.Railway:TokyoMetro.Marunouchi               : #e60012
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : #e60012
  #   odpt.Railway:TokyoMetro.Hibiya                   : #9caeb7
  #   odpt.Railway:TokyoMetro.Tozai                    : #00a7db
  #   odpt.Railway:TokyoMetro.Chiyoda                  : #009945
  #   odpt.Railway:TokyoMetro.Yurakucho                : #d7c447
  #   odpt.Railway:TokyoMetro.Hanzomon                 : #9b7cb6
  #   odpt.Railway:TokyoMetro.Namboku                  : #00ada9
  #   odpt.Railway:TokyoMetro.Fukutoshin               : #bb641d
  #   odpt.Railway:Toei.Asakusa                        : #e85298
  #   odpt.Railway:Toei.Mita                           : #0078c2
  #   odpt.Railway:Toei.Shinjuku                       : #6cbb5a
  #   odpt.Railway:Toei.Oedo                           : #b6007a
  #   odpt.Railway:Toei.NipporiToneri                  : #ff69b4
  #   odpt.Railway:Toei.TodenArakawa                   : #66cc66
  #   odpt.Railway:JR-East.Yamanote                    : #80c241
  #   odpt.Railway:JR-East.KeihinTohoku                : #00b2e5
  #   odpt.Railway:JR-East.Tokaido                     : #f68b1e
  #   odpt.Railway:JR-East.Yokosuka                    : #007ac0
  #   odpt.Railway:JR-East.Takasaki                    : #f68b1e
  #   odpt.Railway:JR-East.Utsunomiya                  : #f68b1e
  #   odpt.Railway:JR-East.ShonanShinjuku              : #e21f26
  #   odpt.Railway:JR-East.UenoTokyo                   : #f68b1e
  #   odpt.Railway:JR-East.Chuo                        : #007ac0
  #   odpt.Railway:JR-East.ChuoKaisoku                 : #f15a22
  #   odpt.Railway:JR-East.ChuoSobu                    : #ffd400
  #   odpt.Railway:JR-East.Sobu                        : #007ac0
  #   odpt.Railway:JR-East.NaritaExpress               : #ff0000
  #   odpt.Railway:JR-East.Saikyo                      : #00b48d
  #   odpt.Railway:JR-East.Joban                       : #00b261
  #   odpt.Railway:JR-East.Keiyo                       : #c9242f
  #   odpt.Railway:JR-East.Musashino                   : #f15a22
  #   odpt.Railway:JR-East.Shinkansen                  : #008000
  #   odpt.Railway:JR-Tokai.Shinkansen                 : #00008b
  #   odpt.Railway:Tokyu.Toyoko                        : #da0442
  #   odpt.Railway:Tokyu.Meguro                        : #009cd2
  #   odpt.Railway:Tokyu.DenEnToshi                    : #20a288
  #   odpt.Railway:Odakyu.Odawara                      : #2288cc
  #   odpt.Railway:Odakyu.Tama                         : #2288cc
  #   odpt.Railway:Odakyu.Enoshima                     : #2288cc
  #   odpt.Railway:Seibu.Ikebukuro                     : #ff6600
  #   odpt.Railway:Seibu.SeibuYurakucho                : #ff6600
  #   odpt.Railway:Seibu.Sayama                        : #ff6600
  #   odpt.Railway:Seibu.Shinjuku                      : #0099cc
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : #0f6cc3
  #   odpt.Railway:Tobu.Skytree                        : #0f6cc3
  #   odpt.Railway:Tobu.Isesaki                        : #ff0000
  #   odpt.Railway:Tobu.Nikko                          : #ffa500
  #   odpt.Railway:Tobu.Tojo                           : #000099
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : #6699ff
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : #3fb036
  #   odpt.Railway:Keio.Keio                           : #dd0077
  #   odpt.Railway:Keio.New                            : #dd0077
  #   odpt.Railway:Keio.Inokashira                     : #000088
  #   odpt.Railway:Keisei.KeiseiMain                   : #005aaa
  #   odpt.Railway:Keisei.KeiseiOshiage                : #005aaa
  #   odpt.Railway:MIR.TX                              : #000084
  #   odpt.Railway:Yurikamome.Yurikamome               : #27404e
  #   odpt.Railway:TWR.Rinkai                          : #00418e
  def color_normal_web
    self.color_normal.web_color
  end

  # 標準の路線色の Red, Green, Blue の各成分の情報を括弧で囲んだ文字列にして返すメソッド
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.color_normal_rgb_in_parentheses }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : ( 243 , 151 , 0 )
  #   odpt.Railway:TokyoMetro.Marunouchi               : ( 230 , 0 , 18 )
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : ( 230 , 0 , 18 )
  #   odpt.Railway:TokyoMetro.Hibiya                   : ( 156 , 174 , 183 )
  #   odpt.Railway:TokyoMetro.Tozai                    : ( 0 , 167 , 219 )
  #   odpt.Railway:TokyoMetro.Chiyoda                  : ( 0 , 153 , 69 )
  #   odpt.Railway:TokyoMetro.Yurakucho                : ( 215 , 196 , 71 )
  #   odpt.Railway:TokyoMetro.Hanzomon                 : ( 155 , 124 , 182 )
  #   odpt.Railway:TokyoMetro.Namboku                  : ( 0 , 173 , 169 )
  #   odpt.Railway:TokyoMetro.Fukutoshin               : ( 187 , 100 , 29 )
  #   odpt.Railway:Toei.Asakusa                        : ( 232 , 82 , 152 )
  #   odpt.Railway:Toei.Mita                           : ( 0 , 120 , 194 )
  #   odpt.Railway:Toei.Shinjuku                       : ( 108 , 187 , 90 )
  #   odpt.Railway:Toei.Oedo                           : ( 182 , 0 , 122 )
  #   odpt.Railway:Toei.NipporiToneri                  : ( 255 , 105 , 180 )
  #   odpt.Railway:Toei.TodenArakawa                   : ( 102 , 204 , 102 )
  #   odpt.Railway:JR-East.Yamanote                    : ( 128 , 194 , 65 )
  #   odpt.Railway:JR-East.KeihinTohoku                : ( 0 , 178 , 229 )
  #   odpt.Railway:JR-East.Tokaido                     : ( 246 , 139 , 30 )
  #   odpt.Railway:JR-East.Yokosuka                    : ( 0 , 122 , 192 )
  #   odpt.Railway:JR-East.Takasaki                    : ( 246 , 139 , 30 )
  #   odpt.Railway:JR-East.Utsunomiya                  : ( 246 , 139 , 30 )
  #   odpt.Railway:JR-East.ShonanShinjuku              : ( 226 , 31 , 38 )
  #   odpt.Railway:JR-East.UenoTokyo                   : ( 246 , 139 , 30 )
  #   odpt.Railway:JR-East.Chuo                        : ( 0 , 122 , 192 )
  #   odpt.Railway:JR-East.ChuoKaisoku                 : ( 241 , 90 , 34 )
  #   odpt.Railway:JR-East.ChuoSobu                    : ( 255 , 212 , 0 )
  #   odpt.Railway:JR-East.Sobu                        : ( 0 , 122 , 192 )
  #   odpt.Railway:JR-East.NaritaExpress               : ( 255 , 0 , 0 )
  #   odpt.Railway:JR-East.Saikyo                      : ( 0 , 180 , 141 )
  #   odpt.Railway:JR-East.Joban                       : ( 0 , 178 , 97 )
  #   odpt.Railway:JR-East.Keiyo                       : ( 201 , 36 , 47 )
  #   odpt.Railway:JR-East.Musashino                   : ( 241 , 90 , 34 )
  #   odpt.Railway:JR-East.Shinkansen                  : ( 0 , 128 , 0 )
  #   odpt.Railway:JR-Tokai.Shinkansen                 : ( 0 , 0 , 139 )
  #   odpt.Railway:Tokyu.Toyoko                        : ( 218 , 4 , 66 )
  #   odpt.Railway:Tokyu.Meguro                        : ( 0 , 156 , 210 )
  #   odpt.Railway:Tokyu.DenEnToshi                    : ( 32 , 162 , 136 )
  #   odpt.Railway:Odakyu.Odawara                      : ( 34 , 136 , 204 )
  #   odpt.Railway:Odakyu.Tama                         : ( 34 , 136 , 204 )
  #   odpt.Railway:Odakyu.Enoshima                     : ( 34 , 136 , 204 )
  #   odpt.Railway:Seibu.Ikebukuro                     : ( 255 , 102 , 0 )
  #   odpt.Railway:Seibu.SeibuYurakucho                : ( 255 , 102 , 0 )
  #   odpt.Railway:Seibu.Sayama                        : ( 255 , 102 , 0 )
  #   odpt.Railway:Seibu.Shinjuku                      : ( 0 , 153 , 204 )
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : ( 15 , 108 , 195 )
  #   odpt.Railway:Tobu.Skytree                        : ( 15 , 108 , 195 )
  #   odpt.Railway:Tobu.Isesaki                        : ( 255 , 0 , 0 )
  #   odpt.Railway:Tobu.Nikko                          : ( 255 , 165 , 0 )
  #   odpt.Railway:Tobu.Tojo                           : ( 0 , 0 , 153 )
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : ( 102 , 153 , 255 )
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : ( 63 , 176 , 54 )
  #   odpt.Railway:Keio.Keio                           : ( 221 , 0 , 119 )
  #   odpt.Railway:Keio.New                            : ( 221 , 0 , 119 )
  #   odpt.Railway:Keio.Inokashira                     : ( 0 , 0 , 136 )
  #   odpt.Railway:Keisei.KeiseiMain                   : ( 0 , 90 , 170 )
  #   odpt.Railway:Keisei.KeiseiOshiage                : ( 0 , 90 , 170 )
  #   odpt.Railway:MIR.TX                              : ( 0 , 0 , 132 )
  #   odpt.Railway:Yurikamome.Yurikamome               : ( 39 , 64 , 78 )
  #   odpt.Railway:TWR.Rinkai                          : ( 0 , 65 , 142 )
  def color_normal_rgb_in_parentheses
    self.color_normal.rgb_in_parentheses
  end

# @!group 路線色に関するメソッド (2)

  # 標準の路線色の R 成分を取得するメソッド
  # @return [Integer]
  def color_normal_red
    self.color_normal.red
  end

  # 標準の路線色の G 成分を取得するメソッド
  # @return [Integer]
  def color_normal_green
    self.color_normal.green
  end

  # 標準の路線色の B 成分を取得するメソッド
  # @return [Integer]
  def color_normal_blue
    self.color_normal.blue
  end

# @!group CSS に関するメソッド

  # CSS のクラスの名称
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.railway_lines.each_value { | line | puts line.same_as.ljust(48) + " : " + line.css_class_name }
  #   =>
  #   odpt.Railway:TokyoMetro.Ginza                    : line_ginza
  #   odpt.Railway:TokyoMetro.Marunouchi               : line_marunouchi
  #   odpt.Railway:TokyoMetro.MarunouchiBranch         : line_tokyo_metro_marunouchi_b
  #   odpt.Railway:TokyoMetro.Hibiya                   : line_hibiya
  #   odpt.Railway:TokyoMetro.Tozai                    : line_tozai
  #   odpt.Railway:TokyoMetro.Chiyoda                  : line_chiyoda
  #   odpt.Railway:TokyoMetro.Yurakucho                : line_yurakucho
  #   odpt.Railway:TokyoMetro.Hanzomon                 : line_hanzomon
  #   odpt.Railway:TokyoMetro.Namboku                  : line_namboku
  #   odpt.Railway:TokyoMetro.Fukutoshin               : line_fukutoshin
  #   odpt.Railway:Toei.Asakusa                        : line_toei_asakusa
  #   odpt.Railway:Toei.Mita                           : line_toei_mita
  #   odpt.Railway:Toei.Shinjuku                       : line_toei_shinjuku
  #   odpt.Railway:Toei.Oedo                           : line_toei_oedo
  #   odpt.Railway:Toei.NipporiToneri                  : line_nippori_toneri
  #   odpt.Railway:Toei.TodenArakawa                   : line_toden_arakawa
  #   odpt.Railway:JR-East.Yamanote                    : line_jr_yamanote
  #   odpt.Railway:JR-East.KeihinTohoku                : line_jr_keihin_tohoku
  #   odpt.Railway:JR-East.Tokaido                     : line_jr_tokaido
  #   odpt.Railway:JR-East.Yokosuka                    : line_jr_yokosuka
  #   odpt.Railway:JR-East.Takasaki                    : line_jr_takasaki
  #   odpt.Railway:JR-East.Utsunomiya                  : line_jr_utsunomiya
  #   odpt.Railway:JR-East.ShonanShinjuku              : line_jr_shonan_shinjuku
  #   odpt.Railway:JR-East.UenoTokyo                   : line_jr_ueno_tokyo
  #   odpt.Railway:JR-East.Chuo                        : line_jr_chuo
  #   odpt.Railway:JR-East.ChuoKaisoku                 : line_jr_chuo_rapid
  #   odpt.Railway:JR-East.ChuoSobu                    : line_jr_chuo_and_sobu_local
  #   odpt.Railway:JR-East.Sobu                        : line_jr_sobu_rapid
  #   odpt.Railway:JR-East.NaritaExpress               : line_jr_narita_exp
  #   odpt.Railway:JR-East.Saikyo                      : line_jr_saikyo
  #   odpt.Railway:JR-East.Joban                       : line_jr_joban
  #   odpt.Railway:JR-East.Keiyo                       : line_jr_keiyo
  #   odpt.Railway:JR-East.Musashino                   : line_jr_musashino
  #   odpt.Railway:JR-East.Shinkansen                  : line_shinkansen_e
  #   odpt.Railway:JR-Central.Shinkansen               : line_tokaido_and_sanyo_shinkansen
  #   odpt.Railway:Tokyu.Toyoko                        : line_tokyu_toyoko
  #   odpt.Railway:Tokyu.Meguro                        : line_tokyu_meguro
  #   odpt.Railway:Tokyu.DenEnToshi                    : line_tokyu_den_en_toshi
  #   odpt.Railway:Odakyu.Odawara                      : line_odakyu_odawara
  #   odpt.Railway:Odakyu.Tama                         : line_odakyu_tama
  #   odpt.Railway:Odakyu.Enoshima                     : line_odakyu_enoshima
  #   odpt.Railway:Seibu.Ikebukuro                     : line_seibu_ikebukuro
  #   odpt.Railway:Seibu.SeibuYurakucho                : line_seibu_yurakucho
  #   odpt.Railway:Seibu.Sayama                        : line_seibu_sayama
  #   odpt.Railway:Seibu.Shinjuku                      : line_seibu_shinjuku
  #   odpt.Railway:Tobu.SkyTreeIsesaki                 : line_tobu_sky_tree_and_isesaki
  #   odpt.Railway:Tobu.Skytree                        : line_tobu_sky_tree
  #   odpt.Railway:Tobu.Isesaki                        : line_tobu_isesaki
  #   odpt.Railway:Tobu.Nikko                          : line_tobu_nikko
  #   odpt.Railway:Tobu.Tojo                           : line_tobu_tojo
  #   odpt.Railway:SaitamaRailway.SaitamaRailway       : line_saitama
  #   odpt.Railway:ToyoRapidRailway.ToyoRapidRailway   : line_toyo_rapid
  #   odpt.Railway:Keio.Keio                           : line_keio
  #   odpt.Railway:Keio.New                            : line_keio_new
  #   odpt.Railway:Keio.Inokashira                     : line_keio_inokashira
  #   odpt.Railway:Keisei.KeiseiMain                   : line_keisei_main
  #   odpt.Railway:Keisei.KeiseiOshiage                : line_keisei_oshiage
  #   odpt.Railway:MIR.TX                              : line_tsukuba_exp
  #   odpt.Railway:Yurikamome.Yurikamome               : line_yurikamome
  #   odpt.Railway:TWR.Rinkai                          : line_rinkai
  def css_class_name
    case @same_as
    when "odpt.Railway:TokyoMetro.MarunouchiBranch"
      "marunouchi_branch"
    when "odpt.Railway:TokyoMetro.ChiyodaBranch"
      "chiyoda_branch"
    when "odpt.Railway:JR-East.Shinkansen"
      "shinkansen_e"
    when "odpt.Railway:JR-Central.Shinkansen"
      "shinkansen_c"
    when "odpt.Railway:YokohamaMinatomiraiRailway.Minatomirai"
      "yokohama_minatomirai_mm"
    when "odpt.Railway:Keio.Keio"
      "keio_line"
    when "odpt.Railway:Yurikamome.Yurikamome"
      "yurikamome_line"
    else
      super( "" , :name_en_with_operator_name )
    end
  end

# @!group 鉄道事業者の駅番号・路線番号に関するメソッド

  # 駅ナンバリングを実施しているか否か
  # @return [Boolean]
  def operator_numbering
    @operator.numbering
  end

  # 路線番号の形
  # @return [Stirng or nil]
  def operator_railway_line_code_shape
    @operator.railway_line_code_shape
  end

  # 駅記号の形
  # @return [Stirng or nil]
  def operator_station_code_shape
    @operator.station_code_shape
  end

# @!group 鉄道事業者の色に関するメソッド (1)

  # 鉄道事業者の色を取得するメソッド
  # @return [::TokyoMetro::StaticDatas::Color]
  def operator_color
    @operator.color
  end

  # 鉄道事業者の色の WebColor を取得するメソッド
  # @return [String]
  def operator_color_web
    @operator.web_color
  end

  # 鉄道事業者の色の Red, Green, Blue の各成分の情報を括弧で囲んだ文字列にして返すメソッド
  # @return [String]
  def operator_color_rgb_in_parentheses
    @operator.rgb_in_parentheses
  end

# @!group 鉄道事業者の色に関するメソッド (2)

  # 鉄道事業者の色の R 成分を取得するメソッド
  # @return [Integer]
  def operator_color_red
    @operator.red
  end

  # 鉄道事業者の色の G 成分を取得するメソッド
  # @return [Integer]
  def operator_color_green
    @operator.green
  end

  # 鉄道事業者の色の B 成分を取得するメソッド
  # @return [Integer]
  def operator_color_blue
    @operator.blue
  end

# @!group SCSS に関するメソッド

  # SCSS で include する、形状を表す mixin を返すメソッド
  # @return [String]
  def included_scss_mixin_for_railway_line_code_shape
    case self.operator_railway_line_code_shape
    when nil
      "rounded_square"
    when "none"
      "rounded_square"
    when "filled_rounded_square" , "stroked_circle" , "stroked_rounded_square"
      "railway_line_code_#{self.operator_railway_line_code_shape}"
    end
  end

  # 塗りつぶしなしの図形の縁取り線の太さを返すメソッド
  # @return [Numeric] 縁取り線を設定する場合
  # @return [nil] 縁取り線を設定しない場合
  def stroke_line_width_of_stroked_line_for_scss( rate: 1 )
    case self.operator_railway_line_code_shape
    when "stroked_circle" , "stroked_rounded_square"
      case self.operator.same_as
      when "odpt.Operator:TokyoMetro" , "odpt.Operator:Toei"
        num = 9
      else
        num = 6
      end
      num * rate
    else
      nil
    end
  end

  # テキストの設定（include する mixin）を返すメソッド
  # @return [::Array]
  def railway_line_code_text_settings_for_scss
    ary = ::Array.new
    # 路線記号が定義されている場合
    if self.name_code_normal.string?
      case self.name_code_normal.length
      when 1
        ary << "railway_line_code_large_letter"
        ary << "railway_line_code_bold"
      else
        ary << "railway_line_code_small_letter"
        case @operator.same_as
        when "odpt.Operator:Tokyu" , "odpt.Operator:YokohamaMinatomiraiRailway" , "odpt.Operator:ToyoRapidRailway"
          ary << "railway_line_code_bold"
        end
      end
    end
    ary
  end

  # データをDBに流し込むメソッド
  # @return [nil]
  # @note 運行事業者名（インスタンス変数 operator）が東京メトロの場合は、{TokyoMetro::Api::RailwayLine::Info}の情報も同時に流し込む。
  def seed
    id_urn , geojson , dc_date = nil , nil , nil

    if @operator == "odpt.Operator:TokyoMetro"
      railway_line_info_in_api = ::TokyoMetro::Api.railway_lines.select{ | railway_line | railway_line.same_as == @same_as }
      raise "Error" unless railway_line_info_in_api.length == 1
      railway_line_info_in_api = railway_line_info_in_api.first

      id_urn = railway_line_info_in_api.id
      geo_json = railway_line_info_in_api.region
      dc_date = railway_line_info_in_api.date
    end

    ::RailwayLine.create(
      same_as: @same_as ,
      name_ja: self.name_ja_inspect ,
      name_hira: self.name_hira_inspect ,
      name_en: self.name_en_inspect ,
      name_ja_normal: self.name_ja_normal ,
      name_ja_with_operator_name_precise: self.name_ja_with_operator_name_precise ,
      name_ja_with_operator_name: self.name_ja_with_operator_name ,
      name_en_normal: self.name_en_normal ,
      name_en_with_operator_name_precise: self.name_en_with_operator_name_precise ,
      name_en_with_operator_name: self.name_en_with_operator_name ,
      index: @index ,
      color: self.color_normal_web ,
      css_class_name: self.css_class_name ,
      name_code: self.name_code_normal ,
      operator_id: ::Operator.find_by( same_as: @operator.same_as ).id ,
      id_urn: id_urn ,
      geo_json: geo_json ,
      dc_date: dc_date
    )

    return nil
  end

# @!group クラスメソッド

  # 与えられたハッシュからインスタンスを作成するメソッド
  # @param same_as [String] 作成するインスタンスの ID キー
  # @param h [Hash] ハッシュ
  # @return [Info]
  def self.generate_from_hash( same_as , h )

    ary_of_keys = [ :name_ja , :name_hira , :name_en , :name_code , :operator , :index , :color ]
    name_ja , name_hira , name_en , name_code , operator_base , index , color_base = ary_of_keys.map { | key_str | generate_from_hash__set_variable( h , key_str ) }

    operator = generate_from_hash__set_operator( operator_base )
    color = generate_from_hash__set_color( color_base )
    self.new( same_as , name_ja , name_hira , name_en , name_code , operator , index , color )
  end

# @!endgroup

  private

  def set_name_ja_display( operator , line , en: false , with_operator: true )
    # 路線名が定義されていない場合
    if line.nil?
      # 事業者名を返す
      return operator
    end

    # 事業者名なしの設定がされている場合
    unless with_operator
      return line
    end

    # 路線名・事業者名がともに定義されている場合
    if line.string? and operator.string?
      # 路線名の先頭に事業者名が付いている場合（京王線、西武有楽町線などを想定）
      # または「設定がローマ字 かつ 路線が新幹線」の場合
      if ( !(en) and /\A#{operator}/ === line ) or ( en and ( /\A#{operator}/ === line or /Shinkansen\Z/ === line or operator == "" ) )
        # 路線名を返す
         return line
      # 路線名の先頭に事業者名が付いていない場合
      else
        # 事業者名と路線名を繋げた文字列を返す
        if en
          return operator + " " + line
        else
          return operator + line
        end
      end
    end

    return nil
  end

  def name_ja_with_operator_name__set_operator_setting
    case @operator.same_as
    when "odpt.Operator:TokyoMetro" , "odpt.Operator:ToeiNipporiToneri"
      false
    else
      #---- 路線による判定 ここから
      case @same_as
      when "odpt.Railway:JR-East.Shinkansen" , "odpt.Railway:JR-Central.Shinkansen"
        false
      else
        true
      end
      #---- 路線による判定 ここまで
    end
  end

  class << self

    private

    # 事業者のインスタンスを取得するメソッド
    # @param operator_base [String] 事業者の ID
    # @return [::TokyoMetro::StaticDatas::Operator::Info]
    def generate_from_hash__set_operator( operator_base )
      operator = ::TokyoMetro::StaticDatas.operators[ operator_base ]
      if operator.nil?
        raise "Error: The operator is not defined."
      else
        return operator
      end
    end

    # 色情報のインスタンスを取得するメソッド
    # @param color_base [Hash or ::Array<Hash>] 色情報のもととなるハッシュ（またはハッシュの配列）
    # @return [::TokyoMetro::StaticDatas::Color] 与えられた変数 color_base がハッシュの場合
    # @return [::Array <::TokyoMetro::StaticDatas::Color>] 与えられた変数 color_base がハッシュの配列の場合
    def generate_from_hash__set_color( color_base )
      if color_base.nil?
        nil
      elsif color_base.instance_of?( ::Hash )
        ::TokyoMetro::StaticDatas::Color::generate_from_hash( color_base )
      elsif color_base.instance_of?( ::Array ) and color_base.all? { |i| i.instance_of?( ::Hash ) }
        color_base.map { | each_color | ::TokyoMetro::StaticDatas::Color::generate_from_hash( each_color ) }
      else
        raise "Error"
      end
    end

  end

end