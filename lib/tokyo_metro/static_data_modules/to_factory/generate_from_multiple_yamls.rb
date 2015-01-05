# YAML から Factory メソッドを経由して自身のインスタンスを取得するメソッドを提供するモジュール（複数の YAML ファイルを利用する場合）
module TokyoMetro::StaticDataModules::ToFactory::GenerateFromMultipleYamls

  extend ::ActiveSupport::Concern

  module ClassMethods

    # 単一の YAML ファイルからインスタンスを作成するメソッド
    # @param filename [String (filename)] YAML ファイルの名称
    # @return [subclass of TokyoMetro::StaticDatas::Fundamental::Hash]
    def generate_list_from_yaml( filename )
      factory_class.from_yaml( filename )
    end

    # 複数の YAML ファイルからインスタンスを作成するメソッド
    # @return [subclass of TokyoMetro::StaticDatas::Fundamental::Hash]
    def generate_from_yamls
      factory_class.from_yamls
    end

  end

end