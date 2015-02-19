# 個別の列車種別の情報（API で定義されている）を扱うクラス
class TokyoMetro::Static::TrainType::InApi::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::InApi
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  # @!group Constructor

  # Constructor
  # @param same_as [String] インスタンスの ID
  # @param name_ja [String] 種別の名称（日本語、正式名称）
  # @param name_ja_display [String] 種別の名称（日本語、略称・表示用）
  # @param name_en [String] 種別の名称（ローマ字表記、正式名称）
  # @param name_en_display [String] 種別の名称（ローマ字表記、略称・表示用）
  def initialize( same_as , name_ja , name_ja_display , name_en , name_en_display )
    @same_as = same_as
    @name_ja = name_ja
    @name_ja_display = name_ja_display
    @name_en = name_en
    @name_en_display = name_en_display
  end

  # @!group 種別の ID、番号に関するメソッド

  # @return [String] インスタンスの ID
  # @example
  #   TokyoMetro::Static.train_types_in_api.each_value { | train_type | puts train_type.same_as }
  #   =>
  #   odpt.TrainType:TokyoMetro.Local
  #   odpt.TrainType:TokyoMetro.LimitedExpress
  #   odpt.TrainType:TokyoMetro.Express
  #   odpt.TrainType:TokyoMetro.HolidayExpress
  #   odpt.TrainType:TokyoMetro.SemiExpress
  #   odpt.TrainType:TokyoMetro.Rapid
  #   odpt.TrainType:TokyoMetro.CommuterRapid
  #   odpt.TrainType:TokyoMetro.ToyoRapid
  #   odpt.TrainType:TokyoMetro.TamaExpress
  #   odpt.TrainType:TokyoMetro.RomanceCar
  #   odpt.TrainType:TokyoMetro.RapidExpress
  #   odpt.TrainType:TokyoMetro.CommuterLimitedExpress
  #   odpt.TrainType:TokyoMetro.CommuterExpress
  #   odpt.TrainType:TokyoMetro.CommuterSemiExpress
  #   odpt.TrainType:TokyoMetro.Unknown
  #   odpt.TrainType:TokyoMetro.Extra
  attr_reader :same_as

  # @!group インスタンスの基本的な情報を取得するメソッド

  # インスタンスの比較に用いるメソッド
  # @return [Integer]
  def <=>( other )
    @same_as <=> other.same_as
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s( indent = 0 )
    self.instance_variables.map { |v|
      k = v.to_s.gsub( /\A\@/ , "" ).ljust(32)
      val = self.instance_variable_get(v).to_s
      " " * indent + k + val
    }.join( "\n" )
  end

  # @!group 種別の名称に関するメソッド (1) - インスタンス変数 正式名称

  # @return [String] 種別の名称（日本語、正式名称）
  # @example
  #   TokyoMetro::Static.train_types_in_api.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_ja }
  #   =>
  #   odpt.TrainType:TokyoMetro.Local                  各停
  #   odpt.TrainType:TokyoMetro.LimitedExpress         特急
  #   odpt.TrainType:TokyoMetro.Express                急行
  #   odpt.TrainType:TokyoMetro.HolidayExpress         土休急行
  #   odpt.TrainType:TokyoMetro.SemiExpress            準急
  #   odpt.TrainType:TokyoMetro.Rapid                  快速
  #   odpt.TrainType:TokyoMetro.CommuterRapid          通勤快速
  #   odpt.TrainType:TokyoMetro.ToyoRapid              東葉快速
  #   odpt.TrainType:TokyoMetro.TamaExpress            多摩急行
  #   odpt.TrainType:TokyoMetro.RomanceCar             特急ロマンスカー
  #   odpt.TrainType:TokyoMetro.RapidExpress           快速急行
  #   odpt.TrainType:TokyoMetro.CommuterLimitedExpress 通勤特急
  #   odpt.TrainType:TokyoMetro.CommuterExpress        通勤急行
  #   odpt.TrainType:TokyoMetro.CommuterSemiExpress    通勤準急
  #   odpt.TrainType:TokyoMetro.Unknown                不明
  #   odpt.TrainType:TokyoMetro.Extra                  臨時
  attr_reader :name_ja

  # @return [String] 種別の名称（ローマ字表記、正式名称）
  # @example
  #   TokyoMetro::Static.train_types_in_api.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_en }
  #   =>
  #   odpt.TrainType:TokyoMetro.Local                  Local
  #   odpt.TrainType:TokyoMetro.LimitedExpress         Limited Express
  #   odpt.TrainType:TokyoMetro.Express                Express
  #   odpt.TrainType:TokyoMetro.HolidayExpress         Express (Holiday)
  #   odpt.TrainType:TokyoMetro.SemiExpress            Semi Express
  #   odpt.TrainType:TokyoMetro.Rapid                  Rapid
  #   odpt.TrainType:TokyoMetro.CommuterRapid          Commuter Rapid
  #   odpt.TrainType:TokyoMetro.ToyoRapid              Toyo Rapid
  #   odpt.TrainType:TokyoMetro.TamaExpress            Tama Express
  #   odpt.TrainType:TokyoMetro.RomanceCar             Romance Car (Limited Express)
  #   odpt.TrainType:TokyoMetro.RapidExpress           Rapid Express
  #   odpt.TrainType:TokyoMetro.CommuterLimitedExpress Commuter Limited Express
  #   odpt.TrainType:TokyoMetro.CommuterExpress        Commuter Express
  #   odpt.TrainType:TokyoMetro.CommuterSemiExpress    Commuter Semi Express
  #   odpt.TrainType:TokyoMetro.Unknown                Unknown
  #   odpt.TrainType:TokyoMetro.Extra                  Extra
  attr_reader :name_en

  # @!group 種別の名称に関するメソッド (2) - インスタンス変数 略称・表示用

  # @return [String] 種別の名称（日本語、略称・表示用）
  # @example
  #   TokyoMetro::Static.train_types_in_api.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_ja_display }
  #   =>
  #   odpt.TrainType:TokyoMetro.Local                  (nil)
  #   odpt.TrainType:TokyoMetro.LimitedExpress         (nil)
  #   odpt.TrainType:TokyoMetro.Express                (nil)
  #   odpt.TrainType:TokyoMetro.HolidayExpress         急行
  #   odpt.TrainType:TokyoMetro.SemiExpress            (nil)
  #   odpt.TrainType:TokyoMetro.Rapid                  (nil)
  #   odpt.TrainType:TokyoMetro.CommuterRapid          (nil)
  #   odpt.TrainType:TokyoMetro.ToyoRapid              (nil)
  #   odpt.TrainType:TokyoMetro.TamaExpress            (nil)
  #   odpt.TrainType:TokyoMetro.RomanceCar             特急
  #   odpt.TrainType:TokyoMetro.RapidExpress           (nil)
  #   odpt.TrainType:TokyoMetro.CommuterLimitedExpress (nil)
  #   odpt.TrainType:TokyoMetro.CommuterExpress        (nil)
  #   odpt.TrainType:TokyoMetro.CommuterSemiExpress    (nil)
  #   odpt.TrainType:TokyoMetro.Unknown                (nil)
  #   odpt.TrainType:TokyoMetro.Extra                  (nil)
  attr_reader :name_ja_display

  # @return [String] 種別の名称（ローマ字表記、略称・表示用）
  # @example
  #   TokyoMetro::Static.train_types_in_api.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_en_display }
  #   =>
  #   odpt.TrainType:TokyoMetro.Local                  (nil)
  #   odpt.TrainType:TokyoMetro.LimitedExpress         (nil)
  #   odpt.TrainType:TokyoMetro.Express                (nil)
  #   odpt.TrainType:TokyoMetro.HolidayExpress         Express
  #   odpt.TrainType:TokyoMetro.SemiExpress            (nil)
  #   odpt.TrainType:TokyoMetro.Rapid                  (nil)
  #   odpt.TrainType:TokyoMetro.CommuterRapid          (nil)
  #   odpt.TrainType:TokyoMetro.ToyoRapid              (nil)
  #   odpt.TrainType:TokyoMetro.TamaExpress            (nil)
  #   odpt.TrainType:TokyoMetro.RomanceCar             Limited Express "Romance Car"
  #   odpt.TrainType:TokyoMetro.RapidExpress           (nil)
  #   odpt.TrainType:TokyoMetro.CommuterLimitedExpress (nil)
  #   odpt.TrainType:TokyoMetro.CommuterExpress        (nil)
  #   odpt.TrainType:TokyoMetro.CommuterSemiExpress    (nil)
  #   odpt.TrainType:TokyoMetro.Unknown                (nil)
  #   odpt.TrainType:TokyoMetro.Extra                  (nil)
  attr_reader :name_en_display

  # @!group 種別の名称に関するメソッド (3) - 標準の名称

  # 種別の名称（日本語、標準）
  # @return [String]
  # @example
  #   TokyoMetro::Static.train_types_in_api.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_ja_normal }
  #   =>
  #   odpt.TrainType:TokyoMetro.Local                  各停
  #   odpt.TrainType:TokyoMetro.LimitedExpress         特急
  #   odpt.TrainType:TokyoMetro.Express                急行
  #   odpt.TrainType:TokyoMetro.HolidayExpress         急行
  #   odpt.TrainType:TokyoMetro.SemiExpress            準急
  #   odpt.TrainType:TokyoMetro.Rapid                  快速
  #   odpt.TrainType:TokyoMetro.CommuterRapid          通勤快速
  #   odpt.TrainType:TokyoMetro.ToyoRapid              東葉快速
  #   odpt.TrainType:TokyoMetro.TamaExpress            多摩急行
  #   odpt.TrainType:TokyoMetro.RomanceCar             特急
  #   odpt.TrainType:TokyoMetro.RapidExpress           快速急行
  #   odpt.TrainType:TokyoMetro.CommuterLimitedExpress 通勤特急
  #   odpt.TrainType:TokyoMetro.CommuterExpress        通勤急行
  #   odpt.TrainType:TokyoMetro.CommuterSemiExpress    通勤準急
  #   odpt.TrainType:TokyoMetro.Unknown                不明
  #   odpt.TrainType:TokyoMetro.Extra                  臨時
  def name_ja_normal
    if @name_ja_display.present?
      @name_ja_display
    else
      @name_ja
    end
  end

  # 種別の名称（ローマ字、標準）
  # @return [String]
  # @example
  #   TokyoMetro::Static.train_types_in_api.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_en_normal }
  #   =>
  #   odpt.TrainType:TokyoMetro.Local                  Local
  #   odpt.TrainType:TokyoMetro.LimitedExpress         Limited Express
  #   odpt.TrainType:TokyoMetro.Express                Express
  #   odpt.TrainType:TokyoMetro.HolidayExpress         Express
  #   odpt.TrainType:TokyoMetro.SemiExpress            Semi Express
  #   odpt.TrainType:TokyoMetro.Rapid                  Rapid
  #   odpt.TrainType:TokyoMetro.CommuterRapid          Commuter Rapid
  #   odpt.TrainType:TokyoMetro.ToyoRapid              Toyo Rapid
  #   odpt.TrainType:TokyoMetro.TamaExpress            Tama Express
  #   odpt.TrainType:TokyoMetro.RomanceCar             Limited Express "Romance Car"
  #   odpt.TrainType:TokyoMetro.RapidExpress           Rapid Express
  #   odpt.TrainType:TokyoMetro.CommuterLimitedExpress Commuter Limited Express
  #   odpt.TrainType:TokyoMetro.CommuterExpress        Commuter Express
  #   odpt.TrainType:TokyoMetro.CommuterSemiExpress    Commuter Semi Express
  #   odpt.TrainType:TokyoMetro.Unknown                Unknown
  #   odpt.TrainType:TokyoMetro.Extra                  Extra
  def name_en_normal
    if @name_en_display.present?
      @name_en_display
    else
      @name_en
    end
  end

  # @!endgroup

end