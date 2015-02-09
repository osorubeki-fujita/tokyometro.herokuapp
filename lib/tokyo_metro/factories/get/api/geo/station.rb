# API から駅情報 odpt:Station のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factories::Get::Api::Geo::Station < TokyoMetro::Factories::Get::Api::MetaClass::Geo
  include ::TokyoMetro::ClassNameLibrary::Api::Station
end