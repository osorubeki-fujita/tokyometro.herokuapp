# 個別の列車種別の情報を扱うクラス (default)
class TokyoMetro::Static::TrainType::Custom::DefaultSetting::Info < TokyoMetro::Static::TrainType::Custom::OtherOperator::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::DefaultSetting
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info

# @!group 種別の ID ・基本情報に関するメソッド - 例を追加するためだけに定義

  # 種別の ID（インスタンス変数）
  # @return [String]
  # @example
  #   TokyoMetro::Static.train_types_default.each_value { | train_type | puts train_type.same_as_alias }
  #   =>
  #   custom.TrainType:TokyoMetro.Default.Local.Normal
  #   custom.TrainType:TokyoMetro.Default.Local.ToTokyu
  #   custom.TrainType:TokyoMetro.Default.Express.ToTokyu
  #   custom.TrainType:TokyoMetro.Default.HolidayExpress
  def same_as_alias
    self.same_as
  end

  #  API 内部の種別情報（インスタンス変数）
  # @return [TokyoMetro::Static::TrainType::InApi]
  # @example
  #   TokyoMetro::Static.train_types_default.each_value { | train_type | puts train_type.same_as.ljust(56) + " " + train_type.train_type.class.name }
  #   =>
  #   custom.TrainType:TokyoMetro.Default.Local.Normal         TokyoMetro::Static::TrainType::InApi::Info
  #   custom.TrainType:TokyoMetro.Default.Local.ToTokyu        TokyoMetro::Static::TrainType::InApi::Info
  #   custom.TrainType:TokyoMetro.Default.Express.ToTokyu      TokyoMetro::Static::TrainType::InApi::Info
  #   custom.TrainType:TokyoMetro.Default.HolidayExpress       TokyoMetro::Static::TrainType::InApi::Info
  def train_type_alias
    self.train_type
  end

# @!group 種別の色に関するメソッド

  # 背景色の情報（インスタンス変数）
  # @return [::TokyoMetro::Static::TrainType::Color::Info or::TokyoMetro::Static::Color::Info]
  # @example
  #   TokyoMetro::Static.train_types_default.each_value { | train_type | puts train_type.same_as.ljust(56) + " " + train_type.bgcolor.class.name }
  #   =>
  #   custom.TrainType:TokyoMetro.Default.Local.Normal         TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:TokyoMetro.Default.Local.ToTokyu        TokyoMetro::Static::Color
  #   custom.TrainType:TokyoMetro.Default.Express.ToTokyu      TokyoMetro::Static::Color
  #   custom.TrainType:TokyoMetro.Default.HolidayExpress       TokyoMetro::Static::TrainType::Color::Info
  def bgcolor_alias
    self.bgcolor
  end

  #  文字色の情報（インスタンス変数）
  # @return [::TokyoMetro::Static::TrainType::Color::Info or::TokyoMetro::Static::Color::Info]
  # @example
  #   TokyoMetro::Static.train_types_default.each_value { | train_type | puts train_type.same_as.ljust(56) + " " + train_type.color.class.name }
  #   =>
  #   custom.TrainType:TokyoMetro.Default.Local.Normal         TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:TokyoMetro.Default.Local.ToTokyu        TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:TokyoMetro.Default.Express.ToTokyu      TokyoMetro::Static::TrainType::Color::Info
  #   custom.TrainType:TokyoMetro.Default.HolidayExpress       TokyoMetro::Static::TrainType::Color::Info
  def color_alias
    self.color
  end

# @!endgroup

end