# 複数の車両所有事業者の情報を扱うクラス（ハッシュ）
class TokyoMetro::Static::TrainOwner::Hash < TokyoMetro::Static::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::TrainOwner
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Hash

end