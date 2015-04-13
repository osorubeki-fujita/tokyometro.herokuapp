# 各種ハッシュを作成するための Factory クラス - 2.2 複数の YAML ファイルからハッシュを作成する際に個別の YAML ファイルを処理
# @note TokyoMetro::Static::TrainType::Custom::Main , TokyoMetro::Static::Operator で使用する。
class TokyoMetro::Factory::Generate::Static::MetaClass::Group::MultipleYamls::EachFile < TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental::FromHash

  class << self
    undef :yaml_file
  end

  private

  def inspect_title_top
    "○"
  end

end