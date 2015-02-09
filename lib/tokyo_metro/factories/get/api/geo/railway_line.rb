# API から路線情報 odpt:Railway のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factories::Get::Api::Geo::RailwayLine < TokyoMetro::Factories::Get::Api::MetaClass::Geo
  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine
end