# API から路線情報 odpt:Railway のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factory::Get::Api::Geo::RailwayLine < TokyoMetro::Factory::Get::Api::MetaClass::Geo
  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine
end