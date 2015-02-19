# 個別の車両所有事業者の情報を扱うクラス
class TokyoMetro::Static::TrainOwner::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainOwner
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

# @!group Constructor

  # Constructor
  # @param same_as [String] キー
  # @param operator [::TokyoMetro::Static::Operator::Info] 鉄道事業者の情報
  def initialize( same_as , operator )
    @same_as = same_as
    @operator = operator
  end

# @!group 車両所有事業者の ID、番号に関するメソッド

  # @return [String] 車両所有事業者の ID キー
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.same_as }
  #   =>
  #   odpt.TrainOwner:TokyoMetro
  #   odpt.TrainOwner:Toei
  #   odpt.TrainOwner:JR-East
  #   odpt.TrainOwner:Tokyu
  #   odpt.TrainOwner:Odakyu
  #   odpt.TrainOwner:Seibu
  #   odpt.TrainOwner:Tobu
  #   odpt.TrainOwner:SaitamaRailway
  #   odpt.TrainOwner:ToyoRapidRailway
  attr_reader :same_as

  # 事業者の番号（整列のための定義）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.same_as.ljust(32) + " : " + train_owner.index.to_s.rjust(2) }
  #   =>
  #   odpt.TrainOwner:TokyoMetro       :  1
  #   odpt.TrainOwner:Toei             :  2
  #   odpt.TrainOwner:JR-East          :  5
  #   odpt.TrainOwner:Tokyu            :  7
  #   odpt.TrainOwner:Odakyu           :  8
  #   odpt.TrainOwner:Seibu            :  9
  #   odpt.TrainOwner:Tobu             : 10
  #   odpt.TrainOwner:SaitamaRailway   : 11
  #   odpt.TrainOwner:ToyoRapidRailway : 12
  def index
    @operator.index
  end

# @!group 車両所有事業者の名称に関するメソッド

  # @return [::TokyoMetro::Static::Operator::Info] 鉄道事業者の情報
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.operator.class.name }
  #   =>
  #   TokyoMetro::Static::Operator::Info
  #   TokyoMetro::Static::Operator::Info
  #   ......
  #   TokyoMetro::Static::Operator::Info
  attr_reader :operator

# @!group インスタンスの基本的な情報を取得するメソッド

  # インスタンスの比較に用いるメソッド
  # @return [Integer]
  def <=>( other )
    @operator <=> other.operator
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s( indent = 0 )
    self.instance_variables.map { |v|
      k = v.to_s.gsub( /\A\@/ , "" ).ljust(32)
      val = self.instance_variable_get(v)

      if v == :@operator
        val = "\n" + val.to_s( indent + 2 )
      else
        val = val.to_s
      end

      " " * indent + k + val
    }.join( "\n" )
  end

# @!group 運行事業者の名称に関するメソッド (1) - 正式名称

  # 事業者の名称（日本語、正式名称）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.name_ja }
  #   =>
  #   ["東京メトロ", "東京地下鉄"]
  #   ["都営地下鉄", "東京都交通局"]
  #   ["JR東日本", "東日本旅客鉄道"]
  #   ["東急電鉄", "東京急行電鉄"]
  #   ["小田急電鉄"]
  #   ["西武鉄道"]
  #   ["東武鉄道"]
  #   ["埼玉高速鉄道"]
  #   ["東葉高速鉄道"]
  def name_ja
    @operator.name_ja
  end

  # 事業者の名称（ローマ字表記、正式名称）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.name_en }
  #   =>
  #   ["Tokyo Metro"]
  #   ["Toei Subway", "Bureau of Transportation Tokyo Metropolitan Government"]
  #   ["JR East", "East Japan Railway Company"]
  #   ["Tokyu Corporation"]
  #   ["Odakyu Electric Railway"]
  #   ["Seibu Railway"]
  #   ["Tobu Railway"]
  #   ["Saitama Railway"]
  #   ["Toyo Rapid Railway"]
  def name_en
    @operator.name_en
  end

# @!group 運行事業者の名称に関するメソッド (2) - 略称・表示用

  # 事業者の名称（日本語、略称・表示用）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.same_as.ljust(32) + " : " + train_owner.name_ja_display }
  #   =>
  #   odpt.TrainOwner:TokyoMetro       : (nil)
  #   odpt.TrainOwner:Toei             : 都営
  #   odpt.TrainOwner:JR-East          : JR
  #   odpt.TrainOwner:Tokyu            : 東急
  #   odpt.TrainOwner:Odakyu           : 小田急
  #   odpt.TrainOwner:Seibu            : 西武
  #   odpt.TrainOwner:Tobu             : 東武
  #   odpt.TrainOwner:SaitamaRailway   : (nil)
  #   odpt.TrainOwner:ToyoRapidRailway : (nil)
  def name_ja_display
    @operator.name_ja_display
  end

  # 事業者の名称（ローマ字表記、略称・表示用）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.same_as.ljust(32) + " : " + train_owner.name_en_display }
  #   =>
  #   odpt.TrainOwner:TokyoMetro       : (nil)
  #   odpt.TrainOwner:Toei             : Toei
  #   odpt.TrainOwner:JR-East          : JR
  #   odpt.TrainOwner:Tokyu            : Tokyu
  #   odpt.TrainOwner:Odakyu           : Odakyu
  #   odpt.TrainOwner:Seibu            : Seibu
  #   odpt.TrainOwner:Tobu             : Tobu
  #   odpt.TrainOwner:SaitamaRailway   : (nil)
  #   odpt.TrainOwner:ToyoRapidRailway : (nil)
  def name_en_display
    @operator.name_en_display
  end

# @!group 運行事業者の名称に関するメソッド (3) - 標準の名称（詳細版）

  # 標準の名称（日本語・詳細版）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.name_ja_normal_precise }
  #   =>
  #   東京メトロ
  #   都営地下鉄
  #   JR東日本
  #   東急電鉄
  #   小田急電鉄
  #   西武鉄道
  #   東武鉄道
  #   埼玉高速鉄道
  #   東葉高速鉄道
  def name_ja_normal_precise
    @operator.name_ja_normal_precise
  end

  # 標準の名称（ローマ字表記・詳細版）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.name_en_normal_precise }
  #   =>
  #   Tokyo Metro
  #   Toei Subway
  #   JR East
  #   Tokyu Corporation
  #   Odakyu Electric Railway
  #   Seibu Railway
  #   Tobu Railway
  #   Saitama Railway
  #   Toyo Rapid Railway
  def name_en_normal_precise
    @operator.name_en_normal_precise
  end

# @!group 運行事業者の名称に関するメソッド (4) - 標準の名称（簡易版）

  # 標準の名称（日本語）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.name_ja_normal }
  #   =>
  #   東京メトロ
  #   都営
  #   JR
  #   東急
  #   小田急
  #   西武
  #   東武
  #   埼玉高速鉄道
  #   東葉高速鉄道
  def name_ja_normal
    @operator.name_ja_normal
  end

  # 標準の名称（ローマ字表記）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.name_en_normal }
  #   =>
  #   Tokyo Metro
  #   Toei
  #   JR
  #   Tokyu
  #   Odakyu
  #   Seibu
  #   Tobu
  #   Saitama Railway
  #   Toyo Rapid Railway
  def name_en_normal
    @operator.name_en_normal
  end

# @!group 運行事業者の名称に関するメソッド (5) - 乗り換え等の情報で使用

  # 乗り換え等の情報で使用する名称（日本語）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.same_as.ljust(32) + " : " + train_owner.name_ja_for_transfer_info }
  #   =>
  #   odpt.TrainOwner:TokyoMetro       : (nil)
  #   odpt.TrainOwner:Toei             : 都営
  #   odpt.TrainOwner:JR-East          : JR
  #   odpt.TrainOwner:Tokyu            : 東急
  #   odpt.TrainOwner:Odakyu           : 小田急
  #   odpt.TrainOwner:Seibu            : 西武
  #   odpt.TrainOwner:Tobu             : 東武
  #   odpt.TrainOwner:SaitamaRailway   : 埼玉高速鉄道
  #   odpt.TrainOwner:ToyoRapidRailway : 東葉高速鉄道
  def name_ja_for_transfer_info
    @operator.name_ja_for_transfer_info
  end

  # 乗り換え等の情報で使用する名称（ローマ字表記）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.same_as.ljust(32) + " : " + train_owner.name_en_for_transfer_info }
  #   =>
  #   odpt.TrainOwner:TokyoMetro       : (nil)
  #   odpt.TrainOwner:Toei             : Toei
  #   odpt.TrainOwner:JR-East          : JR
  #   odpt.TrainOwner:Tokyu            : Tokyu
  #   odpt.TrainOwner:Odakyu           : Odakyu
  #   odpt.TrainOwner:Seibu            : Seibu
  #   odpt.TrainOwner:Tobu             : Tobu
  #   odpt.TrainOwner:SaitamaRailway   : Saitama Railway
  #   odpt.TrainOwner:ToyoRapidRailway : Toyo Rapid Railway
  def name_en_for_transfer_info
    @operator.name_en_for_transfer_info
  end

# @!group 運行事業者の名称に関するメソッド (6) - HAML

  # HAML に表示する名称（日本語）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.same_as.ljust(32) + " : " + train_owner.name_ja_to_haml }
  #   =>
  #   odpt.TrainOwner:TokyoMetro       : 東京メトロ（東京地下鉄）
  #   odpt.TrainOwner:Toei             : 都営地下鉄（東京都交通局）
  #   odpt.TrainOwner:JR-East          : JR東日本（東日本旅客鉄道）
  #   odpt.TrainOwner:Tokyu            : 東急電鉄（東京急行電鉄）
  #   odpt.TrainOwner:Odakyu           : 小田急電鉄
  #   odpt.TrainOwner:Seibu            : 西武鉄道
  #   odpt.TrainOwner:Tobu             : 東武鉄道
  #   odpt.TrainOwner:SaitamaRailway   : 埼玉高速鉄道
  #   odpt.TrainOwner:ToyoRapidRailway : 東葉高速鉄道
  def name_ja_to_haml
    @operator.name_ja_to_haml
  end

  # HAML に表示する名称（ローマ字表記）
  # @return [String]
  # @example
  #   ::TokyoMetro::Static.train_owners.each_value { | train_owner | puts train_owner.same_as.ljust(32) + " : " + train_owner.name_en_to_haml }
  #   =>
  #   odpt.TrainOwner:TokyoMetro       : Tokyo Metro
  #   odpt.TrainOwner:Toei             : Toei Subway (Bureau of Transportation Tokyo Metropolitan Government)
  #   odpt.TrainOwner:JR-East          : JR East (East Japan Railway Company)
  #   odpt.TrainOwner:Tokyu            : Tokyu Corporation
  #   odpt.TrainOwner:Odakyu           : Odakyu Electric Railway
  #   odpt.TrainOwner:Seibu            : Seibu Railway
  #   odpt.TrainOwner:Tobu             : Tobu Railway
  #   odpt.TrainOwner:SaitamaRailway   : Saitama Railway
  #   odpt.TrainOwner:ToyoRapidRailway : Toyo Rapid Railway
  def name_en_to_haml
    @operator.name_en_to_haml
  end

# @!group 運行事業者の駅番号・路線番号に関するメソッド

  # 駅ナンバリングを実施しているか否か
  # @return [Boolean]
  def numbering
    @operator.numbering
  end

  # 駅番号の形
  # @return [Stirng or nil]
  def railway_line_code_shape
    @operator.railway_line_code_shape
  end

  # 路線記号の形
  # @return [Stirng or nil]
  def station_code_shape
    @operator.station_code_shape
  end

# @!group 運行事業者の色に関するメソッド (1)

  # 運行事業者の色情報を取得するメソッド
  # @return [::TokyoMetro::Static::Color]
  def color
    @operator.color
  end

  # 運行事業者の WebColor を取得するメソッド
  # @return [String]
  def web_color
    @operator.web_color
  end

# @!group 運行事業者の色に関するメソッド (2)

  # 運行事業者の色の R 成分の値を返すメソッド
  # @return [Integer]
  def red
    @operator.red
  end

  # 運行事業者の色の G 成分の値を返すメソッド
  # @return [Integer]
  def green
    @operator.green
  end

  # 運行事業者の色の B 成分の値を返すメソッド
  # @return [Integer]
  def blue
    @operator.blue
  end

# @!endgroup

end