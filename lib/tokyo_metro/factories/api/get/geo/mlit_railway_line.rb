# API から国土交通省国土数値情報-鉄道::路線 mlit:Railway の情報を取得するための Factory Pattern のクラス
class TokyoMetro::Factories::Api::Get::Geo::MlitRailwayLine < TokyoMetro::Factories::Api::Get::MetaClass::Geo
  include ::TokyoMetro::ClassNameLibrary::Api::MlitRailwayLine
end