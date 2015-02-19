# データ検索 API を利用する情報を扱うクラス（メタクラス）
class TokyoMetro::Api::MetaClass::DataSearch < TokyoMetro::Api::MetaClass::Fundamental

  include ::TokyoMetro::Modules::Api::ToFactory::Save::Info::DataSearch
  include ::TokyoMetro::Modules::Api::ToFactory::Save::Group::Normal
  include ::TokyoMetro::Modules::Api::ToFactory::Generate::Group::Normal

end