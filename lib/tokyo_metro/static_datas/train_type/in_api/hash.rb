# 複数の個別の列車種別の情報（API で定義されている）を格納するクラス（ハッシュ）
class TokyoMetro::StaticDatas::TrainType::InApi::Hash < TokyoMetro::StaticDatas::Fundamental::Hash
  include ::TokyoMetro::StaticDataModules::Hash::Seed
end