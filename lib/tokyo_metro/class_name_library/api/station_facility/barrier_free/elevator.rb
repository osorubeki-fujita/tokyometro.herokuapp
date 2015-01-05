# 駅施設情報 odpt:StationFacility のバリアフリー施設情報を扱うクラスのリスト（エレベーター）
module TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Elevator

  extend ::ActiveSupport::Concern

  module ClassMethods

    def info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Elevator::Info
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Elevator
    end

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - ug:Elevator
    # @return [String]
    def rdf_type
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