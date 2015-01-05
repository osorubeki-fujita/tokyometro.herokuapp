# 列車種別の情報を扱うクラスの名称を提供するモジュール (1)
module TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::Custom::OtherOperator

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @note "OtherOperators" ... s があることに注意
    def factory_class
      ::TokyoMetro::Factories::StaticDatas::TrainType::Custom::OtherOperators
    end

    # @note "OtherOperator" ... s がないことに注意
    def factory_for_each_file
      ::TokyoMetro::Factories::StaticDatas::TrainType::Custom::OtherOperator
    end

    def toplevel_namespace
      ::TokyoMetro::StaticDatas::TrainType::Custom::OtherOperator
    end

    def hash_class
      ::TokyoMetro::StaticDatas::TrainType::Custom::OtherOperator::Hash
    end

    def info_class
      ::TokyoMetro::StaticDatas::TrainType::Custom::OtherOperator::Info
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