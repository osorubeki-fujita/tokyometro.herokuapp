# 駅時刻表 odpt:StationTimetable を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::StationTimetable

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:StationTimetable
    # @return [String]
    def rdf_type
     "odpt:StationTimetable"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_odpt_StationTimetable.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::StationTimetable )]
    def toplevel_namespace
      ::TokyoMetro::Api::StationTimetable
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::StationTimetable::List )]
    def list_class
      ::TokyoMetro::Api::StationTimetable::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::StationTimetable::Info )]
    def info_class
      ::TokyoMetro::Api::StationTimetable::Info
    end

    def train_list_class
      ::TokyoMetro::Api::StationTimetable::Info::Train::List
    end

    def train_class
      ::TokyoMetro::Api::StationTimetable::Info::Train::Info
    end

    def note_list_class
      ::TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::List
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Get::DataSearch::StationTimetable )]
    def factory_for_getting
      ::TokyoMetro::Factories::Api::Get::DataSearch::StationTimetable
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::Save::DataSearch::StationTimetable )]
    def factory_for_saving
      ::TokyoMetro::Factories::Api::Save::DataSearch::StationTimetable
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::SaveGroupedData::StationTimetable )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factories::Api::SaveGroupedData::StationTimetable
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromHash::StationTimetable )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::StationTimetable
    end

    def factory_for_generating_train_from_hash
      ::TokyoMetro::Factories::Api::GenerateFromHash::StationTimetable::Info::Train
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factories::Api::GenerateFromSavedFile::StationTimetable )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factories::Api::GenerateFromSavedFile::StationTimetable
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "station_timetable"
    end

  end

end