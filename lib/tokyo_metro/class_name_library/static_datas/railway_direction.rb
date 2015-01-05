# 方面の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::StaticDatas::RailwayDirection

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::StaticDatas::RailwayDirection
    end

    # ハッシュのクラス
    # @return [Const (class name)]
    def hash_class
      ::TokyoMetro::StaticDatas::RailwayDirection::Hash
    end

    # ハッシュの値のクラス
    # @return [Const (class name)]
    def info_class
      ::TokyoMetro::StaticDatas::RailwayDirection::Info
    end

    def factory_class
      ::TokyoMetro::Factories::StaticDatas::RailwayDirection
    end

    private

    def yaml_file_basename
      "railway_direction"
    end

  end

end