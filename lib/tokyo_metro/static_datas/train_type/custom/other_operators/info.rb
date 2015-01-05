# 個別の列車種別の情報（他社）を扱うクラス
class TokyoMetro::StaticDatas::TrainType::Custom::OtherOperator::Info

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::Custom::OtherOperator
  include ::TokyoMetro::StaticDataModules::GenerateFromHashSetVariable

# @!group Constructor

  # Constructor
  # @param same_as [String] 作成するインスタンスの ID キー
  def initialize( same_as , train_type , bgcolor , color , operator = nil , railway_line = nil )
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
  #   TokyoMetro::StaticDatas.train_types_other_operator.each_value { | train_type | puts train_type.same_as }
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

  # @return [TokyoMetro::StaticDatas::TrainType::InApi::Info] API 内部の種別情報（インスタンス変数）
  # @example
  #   TokyoMetro::StaticDatas.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.train_type.class.name }
  #   =>
  #   custom.TrainType:Odakyu.Local                    TokyoMetro::StaticDatas::TrainType::InApi::Info
  #   custom.TrainType:Odakyu.SemiExpress              TokyoMetro::StaticDatas::TrainType::InApi::Info
  #   ......
  #   custom.TrainType:Tokyu.CommuterLimitedExpress    TokyoMetro::StaticDatas::TrainType::InApi::Info
  #   custom.TrainType:Tokyu.LimitedExpress            TokyoMetro::StaticDatas::TrainType::InApi::Info
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid      TokyoMetro::StaticDatas::TrainType::InApi::Info
  attr_reader :train_type

# @!group 種別の色に関するメソッド

  # @return [::TokyoMetro::StaticDatas::TrainType::Color::Info or::TokyoMetro::StaticDatas::Color::Info] 背景色の情報（インスタンス変数）
  # @example
  #   TokyoMetro::StaticDatas.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.bgcolor.class.name }
  #   =>
  #   custom.TrainType:Odakyu.Local                    TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Odakyu.SemiExpress              TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Odakyu.TamaExpress              TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Odakyu.RomanceCar               TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Seibu.Local                     TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Seibu.SemiExpress               TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Seibu.Rapid                     TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Seibu.RapidExpress              TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Tobu.SemiExpress                TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Tobu.Express                    TokyoMetro::StaticDatas::Color
  #   custom.TrainType:TobuTojo.Local                  TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tokyu.Local                     TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Tokyu.Meguro.Local              TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Tokyu.SemiExpress               TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Tokyu.Express                   TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Tokyu.HolidayExpress            TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tokyu.CommuterLimitedExpress    TokyoMetro::StaticDatas::Color
  #   custom.TrainType:Tokyu.LimitedExpress            TokyoMetro::StaticDatas::Color
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid      TokyoMetro::StaticDatas::Color
  attr_reader :bgcolor

  # @return [::TokyoMetro::StaticDatas::TrainType::Color::Info or::TokyoMetro::StaticDatas::Color::Info] 文字色の情報（インスタンス変数）
  # @example
  #   TokyoMetro::StaticDatas.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.color.class.name }
  #   =>
  #   custom.TrainType:Odakyu.Local                    TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Odakyu.SemiExpress              TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Odakyu.TamaExpress              TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Odakyu.RomanceCar               TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Seibu.Local                     TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Seibu.SemiExpress               TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Seibu.Rapid                     TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Seibu.RapidExpress              TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tobu.SemiExpress                TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tobu.Express                    TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:TobuTojo.Local                  TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tokyu.Local                     TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tokyu.Meguro.Local              TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tokyu.SemiExpress               TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tokyu.Express                   TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tokyu.HolidayExpress            TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tokyu.CommuterLimitedExpress    TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:Tokyu.LimitedExpress            TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:ToyoRapidRailway.ToyoRapid      TokyoMetro::StaticDatas::TrainType::Color::Info
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
  #   TokyoMetro::StaticDatas.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_ja }
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
  #   TokyoMetro::StaticDatas.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_en }
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
  #   TokyoMetro::StaticDatas.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_ja_normal }
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
  #   TokyoMetro::StaticDatas.train_types_other_operator.each_value { | train_type | puts train_type.same_as.ljust(48) + " " + train_type.name_en_normal }
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

# @!group クラスメソッド

  # 与えられたハッシュからインスタンスを作成するメソッド
  # @param same_as [String] インスタンスの ID として設定する値
  # @param h [Hash] ハッシュ
  # @return [Info]
  def self.generate_from_hash( same_as , h )
    # generate_from_hash__inspect_title( same_as )
    ary = generate_from_hash__variable_array(h)
    self.new( same_as , *ary )
  end

# @!endgroup

  class << self

    private

    def generate_from_hash__title
      "TrainTypeOtherOperator"
    end

    def generate_from_hash__inspect_title( same_as )
      puts "○ #{generate_from_hash__title} #{ same_as }"
    end

    def generate_from_hash__variable_array(h)
      ary = ::Array.new
      ary << generate_from_hash__set_train_type( h , :train_type )
      ary << generate_from_hash__set_color_info( h , :bgcolor )
      ary << generate_from_hash__set_color_info( h , :color )
      ary << generate_from_hash__set_variable( h , :operator )
      ary << generate_from_hash__set_variable( h , :railway_line )

      ary
    end

    def generate_from_hash__set_train_type( h , key )
      train_type_same_as = generate_from_hash__set_variable( h , :train_type )
      unless train_type_same_as.string?
        puts h.to_s
        raise "Error: \"#{ train_type_same_as.to_s }\" (#{train_type_same_as.class.name}) is not valid. (Key: #{key})"
      end
      train_type = ::TokyoMetro::StaticDatas.train_types_in_api[ train_type_same_as ]
      if train_type.nil?
        raise "Error: #{train_type_str}"
      end
      train_type
    end

    def generate_from_hash__set_color_info( h , key )
      color_info = generate_from_hash__set_variable( h , key )
      unless color_info.instance_of?( ::Hash )
        raise "Error: #{color_info.to_s} (key: #{key} / class: #{color_info.class.name})"
      end

      case color_info.keys
      # キーに ref のみが指定されている場合
      when [ "ref" ]
        # 参照するハッシュ
        referenced_hash = ::TokyoMetro::StaticDatas.train_types_color
        # 参照のためのキー
        key_for_reference = color_info[ "ref" ]
        # 標準色として定義された色を取得する
        color = referenced_hash[ key_for_reference ]
        unless color.instance_of?( ::TokyoMetro::StaticDatas::TrainType::Color::Info )
          raise "Error: #{color.class.name}"
        end

      # キーに line_color のみが指定されている場合
      when [ "line_color" ]
        key_of_line_color = color_info[ "line_color" ]
        # ラインカラーを取得する
        color = ::TokyoMetro::StaticDatas.railway_lines.select_color( key_of_line_color )

      # キーに web, red, green, blue がそれぞれ指定されている場合
      when [ "web" , "red" , "green" , "blue" ]
        # 新たに色情報のインスタンスを作成する
        color = ::TokyoMetro::StaticDatas::Color.generate_from_hash( color_info )
      else
        raise "Error"
      end

      return color
    end

  end

end