# データ検索 API と地物情報検索 API 両方を利用する情報を扱うクラス（メタクラス）
class TokyoMetro::Api::MetaClass::Hybrid < TokyoMetro::Api::MetaClass::Fundamental

  include ::TokyoMetro::ApiModules::ToFactoryClass::Save::DataSearch
  include ::TokyoMetro::ApiModules::ToFactoryClass::SaveGroupedData::Normal
  include ::TokyoMetro::ApiModules::ToFactoryClass::GenerateFromSavedFile::Normal

  include ::TokyoMetro::ApiModules::ToFactoryClass::Get::Geo

end