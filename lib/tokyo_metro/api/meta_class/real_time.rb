# データ検索 API を利用する、リアルタイム情報を扱うクラス（メタクラス）
class TokyoMetro::Api::MetaClass::RealTime < TokyoMetro::Api::MetaClass::DataSearch

  include ::TokyoMetro::ApiModules::Common::RealTime
  include ::TokyoMetro::ApiModules::ToFactory::Generate::Group::Date

end