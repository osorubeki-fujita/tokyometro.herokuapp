# 駅の情報（他社線も含む）を扱うクラスのハッシュ (default) を作成するための Factory クラス (2)
class TokyoMetro::Factories::Generate::Static::Station::InEachRailwayLine < TokyoMetro::Factories::Generate::Static::MetaClass::Group::HashInHash::EachFile
  include ::TokyoMetro::ClassNameLibrary::Static::Station
end