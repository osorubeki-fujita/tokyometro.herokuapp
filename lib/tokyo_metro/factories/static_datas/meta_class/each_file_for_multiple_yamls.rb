# 各種ハッシュを作成するための Factory クラス (2)
# @note TokyoMetro::StaticDatas::TrainType::Custom::Main , TokyoMetro::StaticDatas::Operator で使用する。
class TokyoMetro::Factories::StaticDatas::MetaClass::EachFileForMultipleYamls < TokyoMetro::Factories::StaticDatas::MetaClass::Fundamental

  # YAML ファイルからインスタンスを生成するクラスメソッド
  # @param filename [String] ファイル名
  # @note ファイル名は必ず指定しなければならない。
  def self.from_yaml( filename , method_for_hash_class: :hash_class )
    super( filename , method_for_hash_class: method_for_hash_class )
  end

  class << self
    undef :yaml_file
  end

  private

  def inspect_title_top
    "○"
  end

end