# 鉄道事業者の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::StaticDatas::Operator

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::StaticDatas::Operator
    end

    def hash_class
      ::TokyoMetro::StaticDatas::Operator::Hash
    end

    def info_class
      ::TokyoMetro::StaticDatas::Operator::Info
    end

    def factory_class
      ::TokyoMetro::Factories::StaticDatas::Operator
    end

    # SCCS の color ファイルを作成する Factory Pattern Class の名称を返すメソッド
    # @return [Const (class)]
    # @note おそらく、もう使うことはない。
    def scss_color_factory
      ::TokyoMetro::Factories::Scss::Operators::Colors
    end

    private

    def yaml_file_basename
      "operator"
    end

  end

end