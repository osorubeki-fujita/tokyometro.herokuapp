# 列車種別の情報を扱うクラスのハッシュ (default) を作成するための Factory クラス (2)
class TokyoMetro::Factories::StaticDatas::TrainType::Custom::Mains < TokyoMetro::Factories::StaticDatas::MetaClass::MultipleYamls
  include ::TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::Custom::Main
end