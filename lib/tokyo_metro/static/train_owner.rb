# 車両所有事業者の情報を扱うクラス
class TokyoMetro::Static::TrainOwner < TokyoMetro::Static::Fundamental::MetaClass::UsingOneYaml

  include ::TokyoMetro::ClassNameLibrary::Static::TrainOwner

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::Static.const_set( :TRAIN_OWNERS , self.generate_from_yaml )
  end

end