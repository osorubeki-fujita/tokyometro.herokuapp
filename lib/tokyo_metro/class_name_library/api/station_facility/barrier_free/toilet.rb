# 駅施設情報 odpt:StationFacility のバリアフリー施設情報を扱うクラスのリスト（トイレ）
module TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Toilet

  extend ::ActiveSupport::Concern

  module ClassMethods

    def info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Info
    end

    def assinstant_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Assistant
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Toilet
    end

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - ug:Toilet
    # @return [String]
    def rdf_type
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