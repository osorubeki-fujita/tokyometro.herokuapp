# 駅情報（名称、管理事業者など）のハッシュを作成するための Factory クラス
class TokyoMetro::Factory::Generate::Static::StationsInTokyoMetro::Hash < TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental::FromHash
  include ::TokyoMetro::ClassNameLibrary::Static::StationsInTokyoMetro
end