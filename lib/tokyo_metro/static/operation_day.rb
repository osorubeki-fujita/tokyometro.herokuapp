class TokyoMetro::Static::OperationDay < TokyoMetro::Static::Fundamental::MetaClass::UsingOneYaml

  include ::TokyoMetro::ClassNameLibrary::Static::OperationDay

  # @!group 列車運行情報のリスト

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::Static.const_set( :OPERATION_DAYS , self.generate_from_yaml )
  end

  # @!endgroup

end