# 路線の情報を扱うクラス
class TokyoMetro::Static::RailwayLine < TokyoMetro::Static::Fundamental::MetaClass::UsingOneYaml

  include ::TokyoMetro::ClassNameLibrary::Static::RailwayLine

  # @!group 路線のリスト

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::Static.const_set( :RAILWAY_LINES , self.generate_from_yaml )
  end

  # @!endgroup

end