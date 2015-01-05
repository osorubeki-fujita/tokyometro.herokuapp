# 駅の情報（他社線も含む）を扱うクラス
class TokyoMetro::StaticDatas::Station < TokyoMetro::StaticDatas::Fundamental::MetaClass::UsingMultipleYamls

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Station

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::StaticDatas.const_set( :STATIONS , self.generate_from_yamls )
  end

  class << self
    alias :factory_class :toplevel_factory_class
    undef :toplevel_factory_class
  end

end

# station/railway_lines.rb
# station/in_each_railway_line.rb