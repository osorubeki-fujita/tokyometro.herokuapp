# 駅の情報（名称、管理事業者など）を扱うクラス
class TokyoMetro::Static::StationsInTokyoMetro < TokyoMetro::Static::Fundamental::MetaClass::UsingOneYaml

  include ::TokyoMetro::ClassNameLibrary::Static::StationsInTokyoMetro

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::Static.const_set( :STATIONS_IN_TOKYO_METRO , self.generate_from_yaml )
  end

end