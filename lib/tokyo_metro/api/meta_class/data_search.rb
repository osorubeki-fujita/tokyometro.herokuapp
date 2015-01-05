# データ検索 API を利用する情報を扱うクラス（メタクラス）
class TokyoMetro::Api::MetaClass::DataSearch < TokyoMetro::Api::MetaClass::Fundamental

  include ::TokyoMetro::ApiModules::ToFactoryClass::Save::DataSearch
  include ::TokyoMetro::ApiModules::ToFactoryClass::SaveGroupedData::Normal
  include ::TokyoMetro::ApiModules::ToFactoryClass::GenerateFromSavedFile::Normal

end