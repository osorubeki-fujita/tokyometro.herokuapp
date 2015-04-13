# 各種ハッシュを作成するための Factory クラス - 1. 基本（配列から）
class TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental::FromList < TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental

  # YAML ファイルからインスタンスを生成する際のロジック
  # @return [Proc]
  def generating_procedure( d_yaml )
    raise "Error" unless d_yaml.instance_of?( ::Array )

    ary = ::Array.new
    d_yaml.each do | item |
      ary << self.class.info_class_for_this_factory.generate_from_hash( item )
    end
    self.class.list_class_for_this_factory.new( ary )
  end

  def self.list_class_for_this_factory
    list_class
  end

  # 配列のクラス
  # @return [Const (class name)]
  def self.list_class
    raise "The class method \"#{__method__}\" is not defined yet in this class."
  end

end