# 駅情報（名称、管理事業者など）のハッシュを作成するための Factory クラス
class TokyoMetro::Factories::StaticDatas::StationsInTokyoMetro < TokyoMetro::Factories::StaticDatas::MetaClass::Fundamental
  include ::TokyoMetro::ClassNameLibrary::StaticDatas::StationsInTokyoMetro
end