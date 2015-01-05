# 列車種別の色を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::Color

  extend ::ActiveSupport::Concern

  module ClassMethods

    def hash_class
      ::TokyoMetro::StaticDatas::TrainType::Color::Hash
    end

    def info_class
      ::TokyoMetro::StaticDatas::TrainType::Color::Info
    end

    private

    def yaml_file_basename
      "train_type/color"
    end

  end

end