# 方面の情報を扱うクラス
class TokyoMetro::StaticDatas::RailwayDirection < TokyoMetro::StaticDatas::Fundamental::MetaClass::UsingOneYaml

  include TokyoMetro::ClassNameLibrary::StaticDatas::RailwayDirection

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::StaticDatas.const_set( :RAILWAY_DIRECTIONS , self.generate_from_yaml )
  end

end