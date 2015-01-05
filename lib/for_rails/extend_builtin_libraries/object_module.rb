# すべてのオブジェクトの親クラス
module ForRails::ExtendBuiltinLibraries::ObjectModule

  alias :meaningful? :present?

  # 整数か否かを判定するメソッド
  # @return [Boolean]
  def integer?
    self.kind_of?( Integer )
  end

  # 数値か否かを判定するメソッド
  # @return [Boolean]
  def number?
    self.kind_of?( Numeric )
  end

  # 文字列か否かを判定するメソッド
  # @return [Boolean]
  def string?
    self.instance_of?( String )
  end

  # 真偽値か否かを判定するメソッド
  # @return [Boolean]
  def boolean?
    self.instance_of?( TrueClass ) or self.instance_of?( FalseClass )
  end

end