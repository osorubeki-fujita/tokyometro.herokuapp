# 列車種別の情報（実際に時刻表などのクラスから参照されるもの）を扱うクラスのハッシュ (default) を作成するための Factory クラス (2)
class TokyoMetro::Factory::Generate::Static::TrainType::Custom::Main::Hash::EachFile < TokyoMetro::Factory::Generate::Static::MetaClass::Group::MultipleYamls::EachFile
  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::Main
end