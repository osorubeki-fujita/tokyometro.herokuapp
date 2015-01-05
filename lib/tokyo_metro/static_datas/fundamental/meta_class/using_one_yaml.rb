# それぞれの具体的な情報を統括するクラスのメタクラス（単一の YAML ファイルを扱うクラス）
class TokyoMetro::StaticDatas::Fundamental::MetaClass::UsingOneYaml < TokyoMetro::StaticDatas::Fundamental::MetaClass
  include ::TokyoMetro::StaticDataModules::ToFactory::GenerateFromOneYaml
end