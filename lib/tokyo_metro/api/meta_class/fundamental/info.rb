# API から提供されるデータ（メタクラス）
class TokyoMetro::Api::MetaClass::Fundamental::Info

  # クラスメソッドの追加
  include ::TokyoMetro::ApiModules::ClassAttr::NotRealTime
  include ::TokyoMetro::ApiModules::ToFactoryClass::GenerateFromHash

  # インスタンスメソッドの追加
  include ::TokyoMetro::ApiModules::InstanceMethods::ToJson
  include ::TokyoMetro::ApiModules::InstanceMethods::SetDataToHash

  # @return [String] 固有識別子 (ucode) - URN
  attr_reader :id_urn

  class << self
    alias :generate_from_json :generate_from_hash
  end

end