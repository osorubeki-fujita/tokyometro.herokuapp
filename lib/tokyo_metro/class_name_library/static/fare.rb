# 運賃の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::Fare

  extend ::ActiveSupport::Concern

  module ClassMethods

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Static::Fare )]
    def static_toplevel_namespace
      ::TokyoMetro::Static::Fare
    end

    # 東京メトロの運賃表（普通運賃）を扱うクラス
    # @return [Const ( ::TokyoMetro::Static::Fare::Normal )]
    def normal_fare_class
      ::TokyoMetro::Static::Fare::Normal
    end

    # 各料金区間の運賃の配列を扱うクラス
    # @return [Const ( ::TokyoMetro::Static::Fare::Normal::Table )]
    def normal_fare_table_class
      ::TokyoMetro::Static::Fare::Normal::Table
    end

    # 各料金区間の運賃の配列
    # @return [Const ( ::TokyoMetro::Static::Fare::Normal::Table::List )]
    def normal_fare_table_list_class
      ::TokyoMetro::Static::Fare::Normal::Table::List
    end

    # 運賃のパターン（各料金区間の運賃）を扱うクラス
    # @return [Const ( ::TokyoMetro::Static::Fare::Normal::Table::Pattern )]
    def normal_fare_table_pattern_class
      ::TokyoMetro::Static::Fare::Normal::Table::Pattern
    end

    def factory_for_seeding_normal_table_list
      ::TokyoMetro::Factory::Seed::Static::Fare::Normal::Table::List
    end

    def factory_for_seeding_normal_table_pattern
      ::TokyoMetro::Factory::Seed::Static::Fare::Normal::Table::Pattern
    end

    def db_instance_class_of_normal_table_pattern
      ::NormalFareGroup
    end

  end

end