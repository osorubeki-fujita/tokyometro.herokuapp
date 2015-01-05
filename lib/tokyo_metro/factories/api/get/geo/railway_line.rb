# API から路線情報 odpt:Railway のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factories::Api::Get::Geo::RailwayLine < TokyoMetro::Factories::Api::Get::MetaClass::Geo
  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine
end