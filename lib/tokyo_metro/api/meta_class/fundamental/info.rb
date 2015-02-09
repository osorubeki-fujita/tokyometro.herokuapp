# API から提供されるデータ（メタクラス）
class TokyoMetro::Api::MetaClass::Fundamental::Info

  # クラスメソッドの追加
  include ::TokyoMetro::ApiModules::Common::NotRealTime
  include ::TokyoMetro::CommonModules::ToFactory::Generate::Info

  # インスタンスメソッドの追加
  include ::TokyoMetro::ApiModules::Info::ToJson
  include ::TokyoMetro::ApiModules::Info::SetDataToHash

  # @return [String] 固有識別子 (ucode) - URN
  attr_reader :id_urn

end