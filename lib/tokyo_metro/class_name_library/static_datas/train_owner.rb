# 車両所有事業者の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::StaticDatas::TrainOwner

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::StaticDatas::TrainOwner
    end

    def hash_class
      ::TokyoMetro::StaticDatas::TrainOwner::Hash
    end

    def info_class
      ::TokyoMetro::StaticDatas::TrainOwner::Info
    end

    def factory_class
      ::TokyoMetro::Factories::StaticDatas::TrainOwner
    end

    private

    def yaml_file_basename
      "train_owner"
    end

  end

end