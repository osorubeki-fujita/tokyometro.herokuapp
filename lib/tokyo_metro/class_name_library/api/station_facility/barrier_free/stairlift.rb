# 駅施設情報 odpt:StationFacility のバリアフリー施設情報を扱うクラスのリスト（階段昇降機）
module TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Stairlift

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - ug:Link
    # @return [String]
    def rdf_type_of_facility
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