# 列車種別の情報を扱うクラス (default)
class TokyoMetro::Static::TrainType::Custom::DefaultSetting < TokyoMetro::Static::Fundamental::MetaClass::UsingOneYaml
  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::DefaultSetting
end