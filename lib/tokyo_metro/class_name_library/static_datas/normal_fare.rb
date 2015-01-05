# 運賃の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::StaticDatas::Fare

  extend ::ActiveSupport::Concern

  module ClassMethods

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::StaticDatas::Fare )]
    def static_datas_toplevel_namespace
      ::TokyoMetro::StaticDatas::Fare
    end

    # 東京メトロの運賃表（普通運賃）を扱うクラス
    # @return [Const ( ::TokyoMetro::StaticDatas::Fare::Normal )]
    def normal_fare_class
      ::TokyoMetro::StaticDatas::Fare::Normal
    end

    # 各料金区間の運賃の配列を扱うクラス
    # @return [Const ( ::TokyoMetro::StaticDatas::Fare::Normal::Table )]
    def normal_fare_table_class
      ::TokyoMetro::StaticDatas::Fare::Normal::Table
    end

    # 各料金区間の運賃の配列
    # @return [Const ( ::TokyoMetro::StaticDatas::Fare::Normal::Table::List )]
    def normal_fare_table_list_class
      ::TokyoMetro::StaticDatas::Fare::Normal::Table::List
    end

    # 運賃のパターン（各料金区間の運賃）を扱うクラス (Struct)
    # @return [Const ( ::TokyoMetro::StaticDatas::Fare::Normal::Table::Pattern )]
    def normal_fare_table_pattern_class
      ::TokyoMetro::StaticDatas::Fare::Normal::Table::Pattern
    end

  end

end