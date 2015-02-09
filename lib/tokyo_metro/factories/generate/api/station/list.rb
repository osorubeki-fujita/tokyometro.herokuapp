# 保存済みの駅情報 odpt:Station を処理する Factory Pattern のクラス
class TokyoMetro::Factories::Generate::Api::Station::List < TokyoMetro::Factories::Generate::Api::MetaClass::List::Normal
  include ::TokyoMetro::ClassNameLibrary::Api::Station
end