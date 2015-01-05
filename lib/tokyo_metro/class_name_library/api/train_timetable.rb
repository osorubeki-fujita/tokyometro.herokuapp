# 列車時刻表 odpt:TrainTimetable を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:TrainTimetable
    # @return [String]
    def rdf_type
     "odpt:TrainTimetable"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      # "http://vocab.tokyometroapp.jp/context_odpt_TrainTimetable.jsonld"
      "https://vocab.tokyometroapp.jp/context_odpt_TrainTimetable.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::TrainTimetable )]
    def toplevel_namespace
      ::TokyoMetro::Api::TrainTimetable
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::TrainTimetable::List )]
    def list_class
      ::TokyoMetro::Api::TrainTimetable::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::TrainTimetable::Info )]
    def info_class
      ::TokyoMetro::Api::TrainTimetable::Info
    end

    def station_time_list_class
      ::TokyoMetro::Api::TrainTimetable::Info::StationTime::List
    end

    def station_time_class
      ::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::DataSearch::TrainTimetable )]
    def factory_for_getting
      ::TokyoMetro::Factories::Api::Get::DataSearch::TrainTimetable
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::TrainTimetable )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::TrainTimetable
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::TrainTimetable )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::TrainTimetable
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::TrainTimetable )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::TrainTimetable
    end

    def factory_for_generating_station_time_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::TrainTimetable::Info::StationTime
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::TrainTimetable )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::TrainTimetable
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "train_timetable"
    end

  end

end