# 列車ロケーション情報 odpt:Train を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::TrainLocation

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:Train
    # @return [String]
    def rdf_type
      "odpt:Train"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::TrainLocation )]
    def toplevel_namespace
      ::TokyoMetro::Api::TrainLocation
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::TrainLocation::List )]
    def list_class
      ::TokyoMetro::Api::TrainLocation::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::TrainLocation::Info )]
    def info_class
      ::TokyoMetro::Api::TrainLocation::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::DataSearch::TrainLocation )]
    def factory_for_getting
      ::TokyoMetro::Factories::Api::Get::DataSearch::TrainLocation
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::TrainLocation )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::TrainLocation
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::TrainLocation )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::TrainLocation
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::TrainLocation )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::TrainLocation
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::TrainLocation )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::TrainLocation
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "train_location"
    end

  end

end