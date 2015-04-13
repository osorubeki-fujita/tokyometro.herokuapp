# 列車種別の色を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::TrainType::Color

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::TrainType::Color
    end

    def hash_class
      ::TokyoMetro::Static::TrainType::Color::Hash
    end

    def info_class
      ::TokyoMetro::Static::TrainType::Color::Info
    end

    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Static::TrainType::Color::Hash
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::TrainType::Color::Info
    end

    private

    def yaml_file_basename
      "train_type/color"
    end

  end

end