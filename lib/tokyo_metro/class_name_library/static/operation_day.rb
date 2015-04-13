# 曜日の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::OperationDay

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::OperationDay
    end

    def list_class
      ::TokyoMetro::Static::OperationDay::List
    end

    def info_class
      ::TokyoMetro::Static::OperationDay::Info
    end

    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Static::OperationDay::List
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::OperationDay::Info
    end

    def factory_for_seeding_list
      ::TokyoMetro::Factory::Seed::Static::OperationDay::List
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Static::OperationDay::Info
    end

    def db_instance_class
      ::OperationDay
    end

    private

    def yaml_file_basename
      "operation_day"
    end

  end

end