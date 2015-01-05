# 国土交通省国土数値情報-鉄道::駅 mlit:Station を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::MlitStation

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - mlit:Station
    # @return [String]
    def rdf_type
      "mlit:Station"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      # "https://vocab.tokyometroapp.jp/context_mlit_Station.jsonld"
      "http://vocab.tokyometroapp.jp/context_mlit_Station.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::MlitStation )]
    def toplevel_namespace
      ::TokyoMetro::Api::MlitStation
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::MlitStation::List )]
    def list_class
      ::TokyoMetro::Api::MlitStation::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::MlitStation::Info )]
    def info_class
      ::TokyoMetro::Api::MlitStation::Info
    end

    # @!group Factory Pattern のクラスの情報

    # 地物情報検索 API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::Geo::MlitStation )]
    def factory_for_getting_geo
      ::TokyoMetro::Factories::Api::Get::Geo::MlitStation
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::MlitStation )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::MlitStation
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::MlitStation )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::MlitStation
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::MlitStation )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::MlitStation
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::MlitStation )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::MlitStation
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "mlit_station"
    end

  end

end