# 車両所有事業者の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::TrainOwner

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::TrainOwner
    end

    def hash_class
      ::TokyoMetro::Static::TrainOwner::Hash
    end

    def info_class
      ::TokyoMetro::Static::TrainOwner::Info
    end

    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Static::TrainOwner::Hash
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::TrainOwner::Info
    end

    def factory_for_seeding_hash
      ::TokyoMetro::Factory::Seed::Static::TrainOwner::Hash
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Static::TrainOwner::Info
    end

    def db_instance_class
      ::TrainOwner
    end

    private

    def yaml_file_basename
      "train_owner"
    end

  end

end