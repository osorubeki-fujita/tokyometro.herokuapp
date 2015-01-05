# API から駅情報 odpt:Station のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factories::Api::Get::Geo::Station < TokyoMetro::Factories::Api::Get::MetaClass::Geo
  include ::TokyoMetro::ClassNameLibrary::Api::Station
end