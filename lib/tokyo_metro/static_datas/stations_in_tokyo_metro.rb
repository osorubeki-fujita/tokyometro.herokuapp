# 駅の情報（名称、管理事業者など）を扱うクラス
class TokyoMetro::StaticDatas::StationsInTokyoMetro < TokyoMetro::StaticDatas::Fundamental::MetaClass::UsingOneYaml

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::StationsInTokyoMetro

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::StaticDatas.const_set( :STATIONS_IN_TOKYO_METRO , self.generate_from_yaml )
  end

end