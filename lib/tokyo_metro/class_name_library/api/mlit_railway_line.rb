# 国土交通省国土数値情報-鉄道::路線 mlit:Railway を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::MlitRailwayLine

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - mlit:Railway
    # @return [String]
    def rdf_type
       "mlit:Railway"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_mlit_Railway.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::MlitRailwayLine )]
    def toplevel_namespace
      ::TokyoMetro::Api::MlitRailwayLine
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::MlitRailwayLine::List )]
    def list_class
      ::TokyoMetro::Api::MlitRailwayLine::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::MlitRailwayLine::Info )]
    def info_class
      ::TokyoMetro::Api::MlitRailwayLine::Info
    end

    # @!group Factory Pattern のクラスの情報

    # 地物情報検索 API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::Geo::MlitRailwayLine )]
    def factory_for_getting_geo
      ::TokyoMetro::Factories::Api::Get::Geo::MlitRailwayLine
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::MlitRailwayLine )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::MlitRailwayLine
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::MlitRailwayLine )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::MlitRailwayLine
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::MlitRailwayLine )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::MlitRailwayLine
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::MlitRailwayLine )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::MlitRailwayLine
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "mlit_railway_line"
    end

  end

end