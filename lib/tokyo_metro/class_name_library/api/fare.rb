# 運賃 odpt:RailwayFare を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::Fare

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:RailwayFare
    # @return [String]
    def rdf_type
      "odpt:RailwayFare"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_odpt_RailwayFare.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::Fare )]
    def toplevel_namespace
      ::TokyoMetro::Api::Fare
    end
    alias :api_toplevel_namespace :toplevel_namespace

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::Fare::List )]
    def list_class
      ::TokyoMetro::Api::Fare::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::Fare::Info )]
    def info_class
      ::TokyoMetro::Api::Fare::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::DataSearch::Fare )]
    def factory_for_getting
      ::TokyoMetro::Factories::Api::Get::DataSearch::Fare
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::Fare )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::Fare
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::Fare )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::Fare
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::Fare )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::Fare
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::Fare )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::Fare
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "fare"
    end

  end

end