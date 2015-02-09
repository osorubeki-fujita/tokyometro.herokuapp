# 駅情報（名称、管理事業者など）のハッシュを作成するための Factory クラス
class TokyoMetro::Factories::Generate::Static::StationsInTokyoMetro::Hash < TokyoMetro::Factories::Generate::Static::MetaClass::Group::Fundamental::FromHash
  include ::TokyoMetro::ClassNameLibrary::Static::StationsInTokyoMetro
end