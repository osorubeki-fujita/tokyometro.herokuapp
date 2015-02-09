# 駅施設情報 odpt:StationFacility のバリアフリー施設情報を扱うクラスのリスト（エレベーター）
module TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Elevator

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - ug:Elevator
    # @return [String]
    def rdf_type_of_facility
      "ug:Elevator"
    end

    # カテゴリの名称
    # @return [String]
    def category_name
      "エレベーター"
    end

    def category_name_en
      "Elevator"
    end

    # @!endgroup

  end

end