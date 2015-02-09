# 駅施設情報 odpt:StationFacility のバリアフリー施設情報を扱うクラスのリスト（トイレ）
module TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Toilet

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - ug:Toilet
    # @return [String]
    def rdf_type_of_facility
      "ug:Toilet"
    end

    # カテゴリの名称
    # @return [String]
    def category_name
      "トイレ"
    end

    def category_name_en
      "Toilet"
    end

    # @!endgroup

  end

end