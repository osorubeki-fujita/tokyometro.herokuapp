# 個別の「データ検索 API を利用するリアルタイム情報」を扱うクラス（メタクラス）
class TokyoMetro::Api::MetaClass::RealTime::Info < TokyoMetro::Api::MetaClass::Fundamental::Info

  include ::TokyoMetro::ApiModules::ClassAttr::RealTime
  include ::TokyoMetro::ApiModules::InstanceMethods::ValidityOfRealTimeInfo

end