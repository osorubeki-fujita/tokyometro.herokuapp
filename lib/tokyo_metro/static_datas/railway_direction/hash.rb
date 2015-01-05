# 方面の情報を扱うクラス（ハッシュ）
class TokyoMetro::StaticDatas::RailwayDirection::Hash < ::TokyoMetro::StaticDatas::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::RailwayDirection
  include ::TokyoMetro::StaticDataModules::Hash::Seed

end