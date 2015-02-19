# 個別の列車種別の情報（他社）を扱うクラス
class TokyoMetro::Static::TrainType::Custom::OtherOperator::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::OtherOperator
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info

# @!group Constructor

  # Constructor
  # @param same_as [String] 作成するインスタンスの ID キー
  def initialize( same_as , train_type , bgcolor , color , operator , railway_line )
    @same_as = same_as
    @train_type = train_type

    @bgcolor = bgcolor
    @color = color

    @operator = operator
    @railway_line = railway_line
  end

  attr_reader :operator
  attr_reader :railway_line

# @!group 種別の ID ・基本情報に関するメソッド

  # @return [String] 種別の ID（インスタンス変数）
  # @example
  #   TokyoMetro::Static.train_types_other_operator.each_value { | train_type | puts train_type.same_as }
  #   =>
  #   custom.TrainType:Odakyu.Local
  #   custom.TrainType:Odakyu.SemiExpress
  #   custom.TrainType:Odakyu.TamaExpress
  #   custom.TrainType:Odakyu.RomanceCar
  #   custom.TrainType:Seibu.Local
  #   custom.TrainType:Seibu.SemiExpress
  #   custom.TrainType:Seibu.Rapid
  #   custom.TrainType:Seibu.RapidExpress
  #   custom.TrainType:Tobu.SemiExpress
  #   custom.TrainType:Tobu.Express
  #   custom.TrainType:TobuTojo.Local
  #   custom.TrainType:Tokyu.Local
  #   custom.TrainType:Tokyu.Meguro.Local
  #   custom.TrainType:Tokyu.SemiExpress
  #   custom.TrainType:Tokyu.Express
  #   custom.TrainType:Tokyu.HolidayExpress
  #   custom.TrainType:Tokyu.CommuterLimitedExpress
  #   custom.TrainType:Tokyu.LimitedExpress
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid
  attr_reader :same_as

  # @return [TokyoMetro::Static::TrainType::InApi::Info] API 内部の種別情報（インスタンス変数）
  # @example
  #   TokyoMetro::Static.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.train_type.class.name }
  #   =>
  #   custom.TrainType:Odakyu.Local                    TokyoMetro::Static::TrainType::InApi::Info
  #   custom.TrainType:Odakyu.SemiExpress              TokyoMetro::Static::TrainType::InApi::Info
  #   ......
  #   custom.TrainType:Tokyu.CommuterLimitedExpress    TokyoMetro::Static::TrainType::InApi::Info
  #   custom.TrainType:Tokyu.LimitedExpress            TokyoMetro::Static::TrainType::InApi::Info
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid      TokyoMetro::Static::TrainType::InApi::Info
  attr_reader :train_type

# @!group 種別の色に関するメソッド

  # @return [::TokyoMetro::Static::TrainType::Color::Info or::TokyoMetro::Static::Color::Info] 背景色の情報（インスタンス変数）
  # @example
  #   TokyoMetro::Static.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.bgcolor.class.name }
  #   =>
  #   custom.TrainType:Odakyu.Local                    TokyoMetro::Static::Color
  #   custom.TrainType:Odakyu.SemiExpress              TokyoMetro::Static::Color
  #   custom.TrainType:Odakyu.TamaExpress              TokyoMetro::Static::Color
  #   custom.TrainType:Odakyu.RomanceCar               TokyoMetro::Static::Color
  #   custom.TrainType:Seibu.Local                     TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Seibu.SemiExpress               TokyoMetro::Static::Color
  #   custom.TrainType:Seibu.Rapid                     TokyoMetro::Static::Color
  #   custom.TrainType:Seibu.RapidExpress              TokyoMetro::Static::Color
  #   custom.TrainType:Tobu.SemiExpress                TokyoMetro::Static::Color
  #   custom.TrainType:Tobu.Express                    TokyoMetro::Static::Color
  #   custom.TrainType:TobuTojo.Local                  TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tokyu.Local                     TokyoMetro::Static::Color
  #   custom.TrainType:Tokyu.Meguro.Local              TokyoMetro::Static::Color
  #   custom.TrainType:Tokyu.SemiExpress               TokyoMetro::Static::Color
  #   custom.TrainType:Tokyu.Express                   TokyoMetro::Static::Color
  #   custom.TrainType:Tokyu.HolidayExpress            TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tokyu.CommuterLimitedExpress    TokyoMetro::Static::Color
  #   custom.TrainType:Tokyu.LimitedExpress            TokyoMetro::Static::Color
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid      TokyoMetro::Static::Color
  attr_reader :bgcolor

  # @return [::TokyoMetro::Static::TrainType::Color::Info or::TokyoMetro::Static::Color::Info] 文字色の情報（インスタンス変数）
  # @example
  #   TokyoMetro::Static.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.color.class.name }
  #   =>
  #   custom.TrainType:Odakyu.Local                    TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Odakyu.SemiExpress              TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Odakyu.TamaExpress              TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Odakyu.RomanceCar               TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Seibu.Local                     TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Seibu.SemiExpress               TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Seibu.Rapid                     TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Seibu.RapidExpress              TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tobu.SemiExpress                TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tobu.Express                    TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:TobuTojo.Local                  TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tokyu.Local                     TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tokyu.Meguro.Local              TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tokyu.SemiExpress               TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tokyu.Express                   TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tokyu.HolidayExpress            TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tokyu.CommuterLimitedExpress    TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:Tokyu.LimitedExpress            TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid      TokyoMetro::Static::TrainType::Color::Info
  attr_reader :color

# @!group インスタンスの基本的な情報を取得するメソッド

  # インスタンスの比較に用いるメソッド
  # @return [Integer]
  def <=>( other )
    @same_as <=> other.same_as
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s( indent = 0 )
    str_1 = self.instance_variables.map { |v|
      k = v.to_s.gsub( /\A\@/ , "" ).ljust(32)
      val = self.instance_variable_get(v)
      unless v == :@same_as or v == :@note
        val = "\n" + val.to_s( indent + 2 )
      end 
      " " * indent + k + val.to_s
    }.join( "\n" )

    "=" * 96 + "\n" + str_1
  end

# @!group 種別の名称に関するメソッド (1) - 正式名称

  # 種別の名称（日本語、正式名称）
  # @return [String]
  # @example
  #   TokyoMetro::Static.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_ja }
  #   =>
  #   custom.TrainType:Odakyu.Local                    各停
  #   custom.TrainType:Odakyu.SemiExpress              準急
  #   custom.TrainType:Odakyu.TamaExpress              多摩急行
  #   custom.TrainType:Odakyu.RomanceCar               特急ロマンスカー
  #   custom.TrainType:Seibu.Local                     各停
  #   custom.TrainType:Seibu.SemiExpress               準急
  #   custom.TrainType:Seibu.Rapid                     快速
  #   custom.TrainType:Seibu.RapidExpress              快速急行
  #   custom.TrainType:Tobu.SemiExpress                準急
  #   custom.TrainType:Tobu.Express                    急行
  #   custom.TrainType:TobuTojo.Local                  各停
  #   custom.TrainType:Tokyu.Local                     各停
  #   custom.TrainType:Tokyu.Meguro.Local              各停
  #   custom.TrainType:Tokyu.SemiExpress               準急
  #   custom.TrainType:Tokyu.Express                   急行
  #   custom.TrainType:Tokyu.HolidayExpress            土休急行
  #   custom.TrainType:Tokyu.CommuterLimitedExpress    通勤特急
  #   custom.TrainType:Tokyu.LimitedExpress            特急
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid      東葉快速
  def name_ja
    @train_type.name_ja
  end

  # 種別の名称（ローマ字表記、正式名称）
  # @return [String]
  # @example
  #   TokyoMetro::Static.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_en }
  #   =>
  #   custom.TrainType:Odakyu.Local                    Local
  #   custom.TrainType:Odakyu.SemiExpress              Semi Express
  #   custom.TrainType:Odakyu.TamaExpress              Tama Express
  #   custom.TrainType:Odakyu.RomanceCar               Romance Car (Limited Express)
  #   custom.TrainType:Seibu.Local                     Local
  #   custom.TrainType:Seibu.SemiExpress               Semi Express
  #   custom.TrainType:Seibu.Rapid                     Rapid
  #   custom.TrainType:Seibu.RapidExpress              Rapid Express
  #   custom.TrainType:Tobu.SemiExpress                Semi Express
  #   custom.TrainType:Tobu.Express                    Express
  #   custom.TrainType:TobuTojo.Local                  Local
  #   custom.TrainType:Tokyu.Local                     Local
  #   custom.TrainType:Tokyu.Meguro.Local              Local
  #   custom.TrainType:Tokyu.SemiExpress               Semi Express
  #   custom.TrainType:Tokyu.Express                   Express
  #   custom.TrainType:Tokyu.HolidayExpress            Express (Holiday)
  #   custom.TrainType:Tokyu.CommuterLimitedExpress    Commuter Limited Express
  #   custom.TrainType:Tokyu.LimitedExpress            Limited Express
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid      Toyo Rapid
  def name_en
    @train_type.name_en
  end

# @!group 種別の名称に関するメソッド (2) - 標準の名称

  # 種別の名称（日本語、標準）
  # @return [String]
  # @note name_ja_display については特に定義しない。
  # @example
  #   TokyoMetro::Static.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_ja_normal }
  #   =>
  #   custom.TrainType:Odakyu.Local                    各停
  #   custom.TrainType:Odakyu.SemiExpress              準急
  #   custom.TrainType:Odakyu.TamaExpress              多摩急行
  #   custom.TrainType:Odakyu.RomanceCar               特急
  #   custom.TrainType:Seibu.Local                     各停
  #   custom.TrainType:Seibu.SemiExpress               準急
  #   custom.TrainType:Seibu.Rapid                     快速
  #   custom.TrainType:Seibu.RapidExpress              快速急行
  #   custom.TrainType:Tobu.SemiExpress                準急
  #   custom.TrainType:Tobu.Express                    急行
  #   custom.TrainType:TobuTojo.Local                  各停
  #   custom.TrainType:Tokyu.Local                     各停
  #   custom.TrainType:Tokyu.Meguro.Local              各停
  #   custom.TrainType:Tokyu.SemiExpress               準急
  #   custom.TrainType:Tokyu.Express                   急行
  #   custom.TrainType:Tokyu.HolidayExpress            急行
  #   custom.TrainType:Tokyu.CommuterLimitedExpress    通勤特急
  #   custom.TrainType:Tokyu.LimitedExpress            特急
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid      東葉快速
  def name_ja_normal
    @train_type.name_ja_normal
  end

  # 種別の名称（ローマ字、標準）
  # @return [String]
  # @note name_en_display については特に定義しない。
  # @example
  #   TokyoMetro::Static.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_en_normal }
  #   =>
  #   custom.TrainType:Odakyu.Local                    Local
  #   custom.TrainType:Odakyu.SemiExpress              Semi Express
  #   custom.TrainType:Odakyu.TamaExpress              Tama Express
  #   custom.TrainType:Odakyu.RomanceCar               Limited Express "Romance Car"
  #   custom.TrainType:Seibu.Local                     Local
  #   custom.TrainType:Seibu.SemiExpress               Semi Express
  #   custom.TrainType:Seibu.Rapid                     Rapid
  #   custom.TrainType:Seibu.RapidExpress              Rapid Express
  #   custom.TrainType:Tobu.SemiExpress                Semi Express
  #   custom.TrainType:Tobu.Express                    Express
  #   custom.TrainType:TobuTojo.Local                  Local
  #   custom.TrainType:Tokyu.Local                     Local
  #   custom.TrainType:Tokyu.Meguro.Local              Local
  #   custom.TrainType:Tokyu.SemiExpress               Semi Express
  #   custom.TrainType:Tokyu.Express                   Express
  #   custom.TrainType:Tokyu.HolidayExpress            Express
  #   custom.TrainType:Tokyu.CommuterLimitedExpress    Commuter Limited Express
  #   custom.TrainType:Tokyu.LimitedExpress            Limited Express
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid      Toyo Rapid
  def name_en_normal
    @train_type.name_en_normal
  end

# @!endgroup

end