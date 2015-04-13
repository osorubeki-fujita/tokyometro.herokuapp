# 列車種別の情報を扱うクラス (default) の名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::DefaultSetting

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::TrainType::Custom::DefaultSetting
    end

    def hash_class
      ::TokyoMetro::Static::TrainType::Custom::DefaultSetting::Hash
    end

    def info_class
      ::TokyoMetro::Static::TrainType::Custom::DefaultSetting::Info
    end

    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Static::TrainType::Custom::DefaultSetting::Hash
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::TrainType::Custom::DefaultSetting::Info
    end

    private

    def yaml_file_basename
      "train_type/default_settings"
    end

  end

end