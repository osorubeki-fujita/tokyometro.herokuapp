# 列車種別の情報を扱うクラス (default) の名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::Custom::DefaultSetting

  extend ::ActiveSupport::Concern

  module ClassMethods

    def factory_class
      ::TokyoMetro::Factories::StaticDatas::TrainType::Custom::DefaultSetting
    end

    def toplevel_namespace
      ::TokyoMetro::StaticDatas::TrainType::Custom::DefaultSetting
    end

    def hash_class
      ::TokyoMetro::StaticDatas::TrainType::Custom::DefaultSetting::Hash
    end

    def info_class
      ::TokyoMetro::StaticDatas::TrainType::Custom::DefaultSetting::Info
    end

    private

    def yaml_file_basename
      "train_type/default_settings"
    end

  end

end