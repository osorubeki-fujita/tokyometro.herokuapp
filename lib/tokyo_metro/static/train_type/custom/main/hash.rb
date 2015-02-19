# 複数の列車種別の情報（実際に時刻表などのクラスから参照されるもの）を扱うクラス（ハッシュ）
class TokyoMetro::Static::TrainType::Custom::Main::Hash < TokyoMetro::Static::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::Main
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Hash

end