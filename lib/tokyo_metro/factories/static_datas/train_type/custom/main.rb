# 列車種別の情報（実際に時刻表などのクラスから参照されるもの）を扱うクラスのハッシュ (default) を作成するための Factory クラス (1)
class TokyoMetro::Factories::StaticDatas::TrainType::Custom::Main < TokyoMetro::Factories::StaticDatas::MetaClass::EachFileForMultipleYamls
  include ::TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::Custom::Main
end