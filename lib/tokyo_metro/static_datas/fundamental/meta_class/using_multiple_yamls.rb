# それぞれの具体的な情報を統括するクラスのメタクラス（複数の YAML ファイルを扱うクラス）
class TokyoMetro::StaticDatas::Fundamental::MetaClass::UsingMultipleYamls < TokyoMetro::StaticDatas::Fundamental::MetaClass
  include ::TokyoMetro::StaticDataModules::ToFactory::GenerateFromMultipleYamls
end