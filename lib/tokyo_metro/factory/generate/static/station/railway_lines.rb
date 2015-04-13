# 駅の情報（他社線も含む）を扱うクラスのハッシュ (default) を作成するための Factory クラス (1)
class TokyoMetro::Factory::Generate::Static::Station::RailwayLines < TokyoMetro::Factory::Generate::Static::MetaClass::Group::HashInHash
  include ::TokyoMetro::ClassNameLibrary::Static::Station
end