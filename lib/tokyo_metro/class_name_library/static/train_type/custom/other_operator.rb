# 列車種別の情報を扱うクラスの名称を提供するモジュール (1)
module TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::OtherOperator

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::TrainType::Custom::OtherOperator
    end

    def hash_class
      ::TokyoMetro::Static::TrainType::Custom::OtherOperator::Hash
    end

    def info_class
      ::TokyoMetro::Static::TrainType::Custom::OtherOperator::Info
    end

    def factory_for_generating_from_saved_files
      ::TokyoMetro::Factory::Generate::Static::TrainType::Custom::OtherOperator::Hash
    end

    def factory_for_generating_from_each_saved_file
      ::TokyoMetro::Factory::Generate::Static::TrainType::Custom::OtherOperator::Hash::EachFile
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::TrainType::Custom::OtherOperator::Info
    end

    private

    # Hash のインスタンスを作成するときに必要な YAML ファイルのリスト
    # @return [::Array <String (filename)>]
    def yaml_files
      dirname_other_operator = "#{::TokyoMetro::dictionary_dir}/train_type/other_operator"
      Dir.glob( "#{dirname_other_operator}/**.yaml" )
    end

  end

end