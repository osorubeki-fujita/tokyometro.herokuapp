# データ検索 API を利用する情報を扱うクラス（メタクラス）
class TokyoMetro::Api::MetaClass::DataSearch < TokyoMetro::Api::MetaClass::Fundamental

  include ::TokyoMetro::ApiModules::ToFactory::Save::Info::DataSearch
  include ::TokyoMetro::ApiModules::ToFactory::Save::Group::Normal
  include ::TokyoMetro::ApiModules::ToFactory::Generate::Group::Normal

end