# 駅施設情報 odpt:StationFacility のバリアフリー施設情報を扱うクラスのリスト（エスカレーター）
module TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Escalator

  extend ::ActiveSupport::Concern

  module ClassMethods

    def info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::Info
    end

    def service_detail_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Info
    end

    def service_detail_list_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::List
    end

    def service_detail_direction_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Direction
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Escalator
    end

    def factory_of_service_detail
      ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail
    end

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - ug:Escalator
    # @return [String]
    def rdf_type
      "ug:Escalator"
    end

    # 利用可能な車いすの情報
    # @return [String]
    def spac__is_available_to
      "spac:Wheelchair"
    end

    # カテゴリの名称
    # @return [String]
    def category_name
      "エスカレーター"
    end

    def category_name_en
      "Escalator"
    end

    # @!endgroup

  end

end