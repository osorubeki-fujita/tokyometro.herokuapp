# 路線の情報を扱うクラス
class TokyoMetro::StaticDatas::RailwayLine < TokyoMetro::StaticDatas::Fundamental::MetaClass::UsingOneYaml

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::RailwayLine

  # @!group 路線のリスト

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::StaticDatas.const_set( :RAILWAY_LINES , self.generate_from_yaml )
  end

  # @!endgroup

end