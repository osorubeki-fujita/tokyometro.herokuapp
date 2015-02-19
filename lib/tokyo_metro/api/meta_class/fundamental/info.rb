# API から提供されるデータ（メタクラス）
class TokyoMetro::Api::MetaClass::Fundamental::Info

  # クラスメソッドの追加
  include ::TokyoMetro::Modules::Api::Common::NotRealTime
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info

  # インスタンスメソッドの追加
  include ::TokyoMetro::Modules::Api::Info::ToJson
  include ::TokyoMetro::Modules::Api::Info::SetDataToHash

  # @return [String] 固有識別子 (ucode) - URN
  attr_reader :id_urn

end