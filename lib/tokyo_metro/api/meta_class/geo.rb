# 地物情報検索 API を利用する情報を扱うクラス（メタクラス）
class TokyoMetro::Api::MetaClass::Geo < TokyoMetro::Api::MetaClass::Fundamental
  include ::TokyoMetro::Modules::Api::ToFactory::Get::Geo
end