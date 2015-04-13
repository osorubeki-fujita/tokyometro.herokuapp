# 鉄道事業者の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::Operator

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::Operator
    end

    def hash_class
      ::TokyoMetro::Static::Operator::Hash
    end

    def info_class
      ::TokyoMetro::Static::Operator::Info
    end

    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Static::Operator::Hash
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::Operator::Info
    end

    def factory_for_seeding_hash
      ::TokyoMetro::Factory::Seed::Static::Operator::Hash
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Static::Operator::Info
    end

    def db_instance_class
      ::Operator
    end

    # SCCS の color ファイルを作成する Factory Pattern Class の名称を返すメソッド
    # @return [Const (class)]
    # @note おそらく、もう使うことはない。
    def scss_color_factory
      ::TokyoMetro::Factory::Scss::Operators::Colors
    end

    private

    def yaml_file_basename
      "operator"
    end

  end

end