# それぞれの具体的な情報を統括するクラスのメタクラス
class TokyoMetro::StaticDatas::Fundamental::MetaClass

  # インスタンスを生成する Factory Pattern のクラスの名称
  # @return [Const (class)]
  # @raise [RuntimeError] サブクラスで定義するため、このクラスでは例外が発生するようにしている。
  def self.factory_class
    raise "The class method \"#{__method__}\" is not defined yet in this class \"#{self.name}\"."
  end

end