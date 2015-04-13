# 各種ハッシュを作成するための Factory クラス - 1. 基本（ハッシュから）
class TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental::FromHash < TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental

  private

  # YAML ファイルからインスタンスを生成する際のロジック
  # @return [Proc]
  def generating_procedure( d_yaml )
    raise "Error" unless d_yaml.instance_of?( ::Hash )

    group_new = self.class.hash_class_for_this_factory.new
    d_yaml.each do | key , value |
      group_new[ key ] = self.class.info_class_for_this_factory.generate_from_hash( key , value )
    end
    group_new
  end

  def self.hash_class_for_this_factory
    hash_class
  end

  # ハッシュのクラス
  # @return [Const (class name)]
  def self.hash_class
    raise "The class method \"#{__method__}\" is not defined yet in this class."
  end

end