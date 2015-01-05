# YAML から Factory メソッドを経由して自身のインスタンスを取得するメソッドを提供するモジュール（1つの YAML ファイルを利用する場合）
module TokyoMetro::StaticDataModules::ToFactory::GenerateFromOneYaml

  extend ::ActiveSupport::Concern

  module ClassMethods

    # YAML ファイルからインスタンスを作成するメソッド
    # @return [subclass of TokyoMetro::StaticDatas::Fundamental::Hash]
    def generate_from_yaml( method_for_factory_class: :factory_class )
      self.send( method_for_factory_class ).from_yaml
    end

  end

end