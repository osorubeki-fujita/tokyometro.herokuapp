# 駅施設情報 odpt:StationFacility のバリアフリー施設情報を扱うクラスのリスト（基本形）
module TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::MetaClass

  extend ::ActiveSupport::Concern

  module ClassMethods

    def info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Info
    end

    def service_detail_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::ServiceDetail::Info
    end

    def service_detail_list_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::ServiceDetail::List
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree
    end

    def factory_of_service_detail
      ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::ServiceDetail
    end

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定
    # @return [String]
    # @note サブクラスで上書きする。（"ug:Toilet", "spac:Stairlift", "ug:Elevator", "ug:Escalator", "ug:Link" のいずれかが格納される）
    def rdf_type
      raise "Error: The method #{__method__.to_s} is not defined in this class."
    end

    # 施設のカテゴリの名称
    # @return [String]
    # @note サブクラスで上書きする。（「トイレ」「階段昇降機」「エレベータ」「エスカレータ」「ハンドル型電動車いす利用可能経路」のいずれかが格納される）
    def category_name
      raise "Error: The method #{__method__.to_s} is not defined in this class."
    end

    def category_name_en
      raise "Error: The method #{__method__.to_s} is not defined in this class."
    end

    # 車いす対応状況
    # @return [String] サブクラスで上書きされる場合（ハンドル型電動車いす利用可能経路の場合は "spac:MobilityScooter"、車いす対応エスカレータの場合は "spac:Wheelchair" となる）
    # @return [nil] サブクラスで上書きされない場合
    def spac__is_available_to
      nil
    end

    # @!endgroup

  end

end