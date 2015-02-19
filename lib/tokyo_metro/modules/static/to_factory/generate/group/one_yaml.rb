# YAML から Factory メソッドを経由して自身のインスタンスを取得するメソッドを提供するモジュール（1つの YAML ファイルを利用する場合）
module TokyoMetro::Modules::Static::ToFactory::Generate::Group::OneYaml

  extend ::ActiveSupport::Concern

  module ClassMethods

    # YAML ファイルからインスタンスを作成するメソッド
    # @return [subclass of TokyoMetro::Static::Fundamental::Hash]
    # @note 'generate_from_yaml'（単数形）であることに注意
    def generate_from_yaml
      factory_for_generating_from_saved_file_for_this_class.from_yaml
    end

    # 単一のファイルからインスタンスを生成する Factory Pattern のクラスの名称
    # @return [Const (class)]
    # @note
    #   原則として、このモジュール {TokyoMetro::Modules::Static::ToFactory::Generate::Group::OneYaml} が include されているクラスのクラスメソッド factory_for_generating_from_saved_file（クラスを表す定数）が呼び出される。
    #   必要であればサブクラスで上書きする。
    # @note '...saved_file...'（単数形）であることに注意
    def factory_for_generating_from_saved_file_for_this_class
      factory_for_generating_from_saved_file
    end

  end

end