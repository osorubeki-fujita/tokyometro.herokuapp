# それぞれの具体的な情報を統括するクラスのメタクラス（複数の YAML ファイルを扱うクラス）
class TokyoMetro::Static::Fundamental::MetaClass::UsingMultipleYamls
  include ::TokyoMetro::Modules::Static::ToFactory::Generate::Group::MultipleYamls
end