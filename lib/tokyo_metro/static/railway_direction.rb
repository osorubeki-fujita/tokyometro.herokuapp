# 方面の情報を扱うクラス
class TokyoMetro::Static::RailwayDirection < TokyoMetro::Static::Fundamental::MetaClass::UsingOneYaml

  include TokyoMetro::ClassNameLibrary::Static::RailwayDirection

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::Static.const_set( :RAILWAY_DIRECTIONS , self.generate_from_yaml )
  end

end