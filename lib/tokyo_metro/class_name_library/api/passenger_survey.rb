# 駅乗降人員数 odpt:PassengerSurvey を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::PassengerSurvey

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:PassengerSurvey
    # @return [String]
    def rdf_type
      "odpt:PassengerSurvey"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_odpt_PassengerSurvey.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::PassengerSurvey )]
    def toplevel_namespace
      ::TokyoMetro::Api::PassengerSurvey
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::PassengerSurvey::List )]
    def list_class
      ::TokyoMetro::Api::PassengerSurvey::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::PassengerSurvey::Info )]
    def info_class
      ::TokyoMetro::Api::PassengerSurvey::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::DataSearch::PassengerSurvey )]
    def factory_for_getting
      ::TokyoMetro::Factories::Api::Get::DataSearch::PassengerSurvey
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::PassengerSurvey )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::PassengerSurvey
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::PassengerSurvey )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::PassengerSurvey
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::PassengerSurvey )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::PassengerSurvey
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::PassengerSurvey )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::PassengerSurvey
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "passenger_survey"
    end

  end

end