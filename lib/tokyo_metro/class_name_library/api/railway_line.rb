# 路線情報 odpt:Railway を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::RailwayLine

  extend ::ActiveSupport::Concern

  module ClassMethods

  # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:Railway
    # @return [String]
    def rdf_type
      "odpt:Railway"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_odpt_Railway.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::RailwayLine )]
    def toplevel_namespace
      ::TokyoMetro::Api::RailwayLine
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::RailwayLine::List )]
    def list_class
      ::TokyoMetro::Api::RailwayLine::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::RailwayLine::Info )]
    def info_class
      ::TokyoMetro::Api::RailwayLine::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス（データ検索 API）
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::DataSearch::RailwayLine )]
    def factory_for_getting
      ::TokyoMetro::Factories::Api::Get::DataSearch::RailwayLine
    end

    # API からデータを取得するための Factory Pattern クラス（地物検索 API）
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::Geo::RailwayLine )]
    def factory_for_getting_geo
      ::TokyoMetro::Factories::Api::Get::Geo::RailwayLine
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::RailwayLine )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::RailwayLine
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::RailwayLine )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::RailwayLine
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::RailwayLine )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::RailwayLine
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::RailwayLine )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::RailwayLine
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "railway_line"
    end

  end

end