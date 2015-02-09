# API で定義されている列車種別情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::TrainType::InApi

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::TrainType::InApi
    end

    def hash_class
      ::TokyoMetro::Static::TrainType::InApi::Hash
    end

    def info_class
      ::TokyoMetro::Static::TrainType::InApi::Info
    end

    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Generate::Static::TrainType::InApi::Hash
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Generate::Static::TrainType::InApi::Info
    end

    def factory_for_seeding_hash
      ::TokyoMetro::Factories::Seed::Static::TrainType::InApi::Hash
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factories::Seed::Static::TrainType::InApi::Info
    end

    def db_instance_class
      ::TrainTypeInApi
    end

    private

    def yaml_file_basename
      "train_type/in_api"
    end

  end

end