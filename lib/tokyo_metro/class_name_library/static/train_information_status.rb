# 列車運行情報の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::TrainInformationStatus

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::TrainInformationStatus
    end

    def list_class
      ::TokyoMetro::Static::TrainInformationStatus::List
    end

    def info_class
      ::TokyoMetro::Static::TrainInformationStatus::Info
    end

    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Static::TrainInformationStatus::List
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::TrainInformationStatus::Info
    end

    def factory_for_seeding_list
      ::TokyoMetro::Factory::Seed::Static::TrainInformationStatus::List
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Static::TrainInformationStatus::Info
    end

    def db_instance_class
      ::TrainInformationStatus
    end

    private

    def yaml_file_basename
      "train_information_status"
    end

  end

end