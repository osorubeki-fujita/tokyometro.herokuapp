# 駅の情報（他社線も含む）を扱うクラス
class TokyoMetro::Static::Station < TokyoMetro::Static::Fundamental::MetaClass::UsingMultipleYamls

  include ::TokyoMetro::ClassNameLibrary::Static::Station

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::Static.const_set( :STATIONS , self.generate_from_yamls )
  end

end