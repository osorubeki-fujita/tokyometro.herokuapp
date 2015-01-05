# 駅施設情報 odpt:StationFacility のバリアフリー施設情報を扱うクラスのリスト（階段昇降機）
module TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Stairlift

  extend ::ActiveSupport::Concern

  module ClassMethods

    def info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Stairlift::Info
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Stairlift
    end

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - ug:Link
    # @return [String]
    def rdf_type
      "spac:Stairlift"
    end

    # カテゴリの名称
    # @return [String]
    def category_name
      "階段昇降機"
    end

    def category_name_en
      "Stairlift"
    end

    # @!endgroup

  end

end