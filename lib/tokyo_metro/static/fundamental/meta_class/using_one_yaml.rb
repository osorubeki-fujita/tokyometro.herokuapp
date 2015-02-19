# それぞれの具体的な情報を統括するクラスのメタクラス（単一の YAML ファイルを扱うクラス）
class TokyoMetro::Static::Fundamental::MetaClass::UsingOneYaml
  include ::TokyoMetro::Modules::Static::ToFactory::Generate::Group::OneYaml
end