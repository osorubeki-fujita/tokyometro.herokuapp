# データ検索 API と地物情報検索 API 両方を利用する情報を扱うクラス（メタクラス）
class TokyoMetro::Api::MetaClass::Hybrid < TokyoMetro::Api::MetaClass::Fundamental

  include ::TokyoMetro::ApiModules::ToFactory::Save::Info::DataSearch
  include ::TokyoMetro::ApiModules::ToFactory::Save::Group::Normal
  include ::TokyoMetro::ApiModules::ToFactory::Generate::Group::Normal

  include ::TokyoMetro::ApiModules::ToFactory::Get::Geo

end