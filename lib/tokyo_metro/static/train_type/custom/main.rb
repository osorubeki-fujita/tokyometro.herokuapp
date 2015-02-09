# 列車種別の情報（実際に時刻表などのクラスから参照されるもの）を扱うクラス
class TokyoMetro::Static::TrainType::Custom::Main < TokyoMetro::Static::Fundamental::MetaClass::UsingMultipleYamls
  include TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::Main
end