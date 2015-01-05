# API から国土交通省国土数値情報-鉄道::駅 mlit:Station の情報を取得するための Factory Pattern のクラス
class TokyoMetro::Factories::Api::Get::Geo::MlitStation < TokyoMetro::Factories::Api::Get::MetaClass::Geo
  include ::TokyoMetro::ClassNameLibrary::Api::MlitStation
end