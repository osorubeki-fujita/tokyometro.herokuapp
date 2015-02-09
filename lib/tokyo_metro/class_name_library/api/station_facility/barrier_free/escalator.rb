# 駅施設情報 odpt:StationFacility のバリアフリー施設情報を扱うクラスのリスト（エスカレーター）
module TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Escalator

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - ug:Escalator
    # @return [String]
    def rdf_type_of_facility
      "ug:Escalator"
    end

    # カテゴリの名称
    # @return [String]
    def category_name
      "エスカレーター"
    end

    def category_name_en
      "Escalator"
    end

    # 利用可能な車いすの情報
    # @return [String]
    def spac__is_available_to
      "spac:Wheelchair"
    end

    # @!endgroup

  end

end