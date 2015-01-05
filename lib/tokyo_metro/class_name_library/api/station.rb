# 駅情報 odpt:Station を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::Station

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:Station
    # @return [String]
    def rdf_type
      "odpt:Station"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_odpt_Station.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::Station )]
    def toplevel_namespace
      ::TokyoMetro::Api::Station
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::Station::List )]
    def list_class
      ::TokyoMetro::Api::Station::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::Station::Info )]
    def info_class
      ::TokyoMetro::Api::Station::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス（データ検索 API）
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::DataSearch::Station )]
    def factory_for_getting
      ::TokyoMetro::Factories::Api::Get::DataSearch::Station
    end

    # API からデータを取得するための Factory Pattern クラス（地物検索 API）
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::Geo::Station )]
    def factory_for_getting_geo
      ::TokyoMetro::Factories::Api::Get::Geo::Station
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::Station )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::Station
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::Station )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::Station
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::Station )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::Station
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::Station )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::Station
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "station"
    end

  end

end