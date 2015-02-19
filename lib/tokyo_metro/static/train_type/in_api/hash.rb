# 複数の個別の列車種別の情報（API で定義されている）を格納するクラス（ハッシュ）
class TokyoMetro::Static::TrainType::InApi::Hash < TokyoMetro::Static::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::InApi
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Hash

end