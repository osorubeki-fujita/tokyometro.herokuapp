# 地物情報 ug:Poi を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::Point

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - ug:Poi
    # @return [String]
    def rdf_type
       "ug:Poi"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_ug_Poi.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::Point )]
    def toplevel_namespace
      ::TokyoMetro::Api::Point
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::Point::List )]
    def list_class
      ::TokyoMetro::Api::Point::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::Point::Info )]
    def info_class
      ::TokyoMetro::Api::Point::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス（データ検索 API）
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::DataSearch::Point )]
    def factory_for_getting
      ::TokyoMetro::Factories::Api::Get::DataSearch::Point
    end

    # API からデータを取得するための Factory Pattern クラス（地物検索 API）
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::Geo::Point )]
    def factory_for_getting_geo
      ::TokyoMetro::Factories::Api::Get::Geo::Point
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::Point )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::Point
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::Point )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::Point
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::Point )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::Point
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::Point )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::Point
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "point"
    end

  end

end