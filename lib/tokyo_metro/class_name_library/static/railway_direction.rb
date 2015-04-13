# 方面の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::RailwayDirection

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::RailwayDirection
    end

    # ハッシュのクラス
    # @return [Const (class name)]
    def hash_class
      ::TokyoMetro::Static::RailwayDirection::Hash
    end

    # ハッシュの値のクラス
    # @return [Const (class name)]
    def info_class
      ::TokyoMetro::Static::RailwayDirection::Info
    end

    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Static::RailwayDirection::Hash
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::RailwayDirection::Info
    end

    def factory_for_seeding_hash
      ::TokyoMetro::Factory::Seed::Static::RailwayDirection::Hash
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Static::RailwayDirection::Info
    end

    def db_instance_class
      ::RailwayDirection
    end

    private

    def yaml_file_basename
      "railway_direction"
    end

  end

end