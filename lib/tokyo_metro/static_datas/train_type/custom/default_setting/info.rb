# 個別の列車種別の情報を扱うクラス (default)
class TokyoMetro::StaticDatas::TrainType::Custom::DefaultSetting::Info < TokyoMetro::StaticDatas::TrainType::Custom::OtherOperator::Info

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::Custom::DefaultSetting

# @!group 種別の ID ・基本情報に関するメソッド - 例を追加するためだけに定義

  # 種別の ID（インスタンス変数）
  # @return [String]
  # @example
  #   TokyoMetro::StaticDatas.train_types_default.each_value { | train_type | puts train_type.same_as_alias }
  #   =>
  #   custom.TrainType:TokyoMetro.Default.Local.Normal
  #   custom.TrainType:TokyoMetro.Default.Local.ToTokyu
  #   custom.TrainType:TokyoMetro.Default.Express.ToTokyu
  #   custom.TrainType:TokyoMetro.Default.HolidayExpress
  def same_as_alias
    self.same_as
  end

  #  API 内部の種別情報（インスタンス変数）
  # @return [TokyoMetro::StaticDatas::TrainType::InApi]
  # @example
  #   TokyoMetro::StaticDatas.train_types_default.each_value { | train_type | puts train_type.same_as.ljust(56) + " " + train_type.train_type.class.name }
  #   =>
  #   custom.TrainType:TokyoMetro.Default.Local.Normal         TokyoMetro::StaticDatas::TrainType::InApi::Info
  #   custom.TrainType:TokyoMetro.Default.Local.ToTokyu        TokyoMetro::StaticDatas::TrainType::InApi::Info
  #   custom.TrainType:TokyoMetro.Default.Express.ToTokyu      TokyoMetro::StaticDatas::TrainType::InApi::Info
  #   custom.TrainType:TokyoMetro.Default.HolidayExpress       TokyoMetro::StaticDatas::TrainType::InApi::Info
  def train_type_alias
    self.train_type
  end

# @!group 種別の色に関するメソッド

  # 背景色の情報（インスタンス変数）
  # @return [::TokyoMetro::StaticDatas::TrainType::Color::Info or::TokyoMetro::StaticDatas::Color::Info]
  # @example
  #   TokyoMetro::StaticDatas.train_types_default.each_value { | train_type | puts train_type.same_as.ljust(56) + " " + train_type.bgcolor.class.name }
  #   =>
  #   custom.TrainType:TokyoMetro.Default.Local.Normal         TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:TokyoMetro.Default.Local.ToTokyu        TokyoMetro::StaticDatas::Color
  #   custom.TrainType:TokyoMetro.Default.Express.ToTokyu      TokyoMetro::StaticDatas::Color
  #   custom.TrainType:TokyoMetro.Default.HolidayExpress       TokyoMetro::StaticDatas::TrainType::Color::Info
  def bgcolor_alias
    self.bgcolor
  end

  #  文字色の情報（インスタンス変数）
  # @return [::TokyoMetro::StaticDatas::TrainType::Color::Info or::TokyoMetro::StaticDatas::Color::Info]
  # @example
  #   TokyoMetro::StaticDatas.train_types_default.each_value { | train_type | puts train_type.same_as.ljust(56) + " " + train_type.color.class.name }
  #   =>
  #   custom.TrainType:TokyoMetro.Default.Local.Normal         TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:TokyoMetro.Default.Local.ToTokyu        TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:TokyoMetro.Default.Express.ToTokyu      TokyoMetro::StaticDatas::TrainType::Color::Info
  #   custom.TrainType:TokyoMetro.Default.HolidayExpress       TokyoMetro::StaticDatas::TrainType::Color::Info
  def color_alias
    self.color
  end

# @!endgroup

# @!group クラスメソッド

  # 与えられたハッシュからインスタンスを作成するメソッド
  # @param same_as [String] インスタンスの ID として設定する値
  # @param h [Hash] ハッシュ
  # @return [Info]
  def self.generate_from_hash( same_as , h )
    # generate_from_hash__inspect_title( same_as )
    ary_of_keys = generate_from_hash__decided_array_of_keys(h)

    case ary_of_keys
    # キーに ref のみが指定されている場合
    when [ "ref" ]
      info = generate_from_hash__info_from_hash(h)
      self.new( same_as , info.train_type , info.bgcolor , info.color , info.operator , info.railway_line )
    # キーに ref 以外が指定されている場合
    else
      # generate_from_hash__variable_array は、TokyoMetro::StaticDatas::TrainType::Custom::OtherOperator::Info で定義
      ary = generate_from_hash__variable_array( h )
      self.new( same_as , *ary )
    end
  end

# @!endgroup

  class << self

    private

    def generate_from_hash__title
      "TrainTypeDefault"
    end

    def generate_from_hash__decided_array_of_keys(h)
      h.keys
    end

    # すでに他社の色として定義されている色を取得する（東急を想定）
    def generate_from_hash__info_from_hash(h)
      # 参照するハッシュ
      referenced_hash = generate_from_hash__referenced_hash
      # 参照のためのキー
      key_for_reference = h[ "ref" ]
      # ハッシュから取得する値
      info = referenced_hash[ key_for_reference ]

      generate_from_hash__check_validity_of_info( info , key_for_reference )

      return info
    end

    # @note {TokyoMetro::StaticDatas::TrainType::Custom::Main::Info} で上書き
    def generate_from_hash__referenced_hash
      ::TokyoMetro::StaticDatas.train_types_other_operator
    end

    def generate_from_hash__check_validity_of_info( info , key_for_reference , kind_of: false )
      class_name = ::TokyoMetro::StaticDatas::TrainType::Custom::OtherOperator::Info
      if !( ( kind_of and info.kind_of?( class_name ) ) or info.instance_of?( class_name ) )
        str = "Error: The variable \"info\" is not valid. ("
        if key_for_reference.present?
          str << "Key for reference: #{key_for_reference}, "
        end
        str << "Class: #{info.class.name})"
        raise str
      elsif info.nil?
        raise "Error"
      end
    end

  end

end