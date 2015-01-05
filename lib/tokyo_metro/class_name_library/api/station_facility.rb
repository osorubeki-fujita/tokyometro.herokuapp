# 駅施設情報 odpt:StationFacility を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::StationFacility

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:StationFacility
    # @return [String]
    def rdf_type
      "odpt:StationFacility"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_odpt_StationFacility.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::StationFacility )]
    def toplevel_namespace
      ::TokyoMetro::Api::StationFacility
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::StationFacility::List )]
    def list_class
      ::TokyoMetro::Api::StationFacility::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::StationFacility::Info )]
    def info_class
      ::TokyoMetro::Api::StationFacility::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::DataSearch::StationFacility )]
    def factory_for_getting
      ::TokyoMetro::Factories::Api::Get::DataSearch::StationFacility
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::StationFacility )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::StationFacility
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::StationFacility )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::StationFacility
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::StationFacility )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::StationFacility
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "station_facility"
    end

  end

end