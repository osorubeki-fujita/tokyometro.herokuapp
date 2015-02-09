# 鉄道事業者の情報を扱うクラス
class TokyoMetro::Static::Operator < TokyoMetro::Static::Fundamental::MetaClass::UsingOneYaml

  include ::TokyoMetro::ClassNameLibrary::Static::Operator

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::Static.const_set( :OPERATORS , self.generate_from_yaml )
  end

end