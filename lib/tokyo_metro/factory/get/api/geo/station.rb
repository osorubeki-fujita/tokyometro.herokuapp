# API から駅情報 odpt:Station のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factory::Get::Api::Geo::Station < TokyoMetro::Factory::Get::Api::MetaClass::Geo
  include ::TokyoMetro::ClassNameLibrary::Api::Station
end