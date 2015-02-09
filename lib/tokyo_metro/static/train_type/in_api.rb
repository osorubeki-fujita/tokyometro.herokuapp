# API で定義されている列車種別情報を扱うクラス
class TokyoMetro::Static::TrainType::InApi < TokyoMetro::Static::Fundamental::MetaClass::UsingOneYaml
  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::InApi
end