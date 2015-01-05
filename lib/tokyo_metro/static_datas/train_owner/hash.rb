# 複数の車両所有事業者の情報を扱うクラス（ハッシュ）
class TokyoMetro::StaticDatas::TrainOwner::Hash < ::TokyoMetro::StaticDatas::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::TrainOwner
  include ::TokyoMetro::StaticDataModules::Hash::Seed

end