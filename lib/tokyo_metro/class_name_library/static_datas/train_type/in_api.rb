# API で定義されている列車種別情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::InApi

  extend ::ActiveSupport::Concern

  module ClassMethods

    def hash_class
      ::TokyoMetro::StaticDatas::TrainType::InApi::Hash
    end

    def info_class
      ::TokyoMetro::StaticDatas::TrainType::InApi::Info
    end

    private

    def yaml_file_basename
      "train_type/in_api"
    end

  end

end