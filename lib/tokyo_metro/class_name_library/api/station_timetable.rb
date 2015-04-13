# 駅時刻表 odpt:StationTimetable を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::StationTimetable

  extend ::ActiveSupport::Concern
  include ::TokyoMetro::ClassNameLibrary::Api::StationTrainTime::Db

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
      ::TokyoMetro::Api::StationTimetable::Info::TrainTime::List
    end

    def train_info_class
      ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info
    end

    def train_info_note_list_class
      ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::List
    end

    def fundamental_list_class
      ::TokyoMetro::Api::StationTimetable::Info::Fundamental::List
    end

    def fundamental_info_class
      ::TokyoMetro::Api::StationTimetable::Info::Fundamental::Info
    end

    def fundamental_info_separeted_list
      ::TokyoMetro::Api::StationTimetable::Info::Fundamental::Info::Separated::List
    end

    def fundamental_info_separeted_info
      ::TokyoMetro::Api::StationTimetable::Info::Fundamental::Info::Separated::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Get::Api::DataSearch::StationTimetable )]
    def factory_for_getting
      ::TokyoMetro::Factory::Get::Api::DataSearch::StationTimetable
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::StationTimetable::EachFile )]
    def factory_for_saving_to_each_file
      ::TokyoMetro::Factory::Save::Api::StationTimetable::EachFile
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::StationTimetable::Group )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factory::Save::Api::StationTimetable::Group
    end

    def list_class_for_saving_grouped_infos
      ::TokyoMetro::Factory::Save::Api::StationTimetable::Group::List
    end

    def file_info_class_for_saving
      ::TokyoMetro::Factory::Save::Api::StationTimetable::Group::FileInfo
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::StationTimetable::Info )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationTimetable::Info
    end

    def factory_for_generating_fundamental_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationTimetable::Info::Fundamental::Info
    end

    def factory_for_generating_train_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationTimetable::Info::TrainTime::Info
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::StationTimetable::List )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Api::StationTimetable::List
    end

    def factory_for_seeding_list
      ::TokyoMetro::Factory::Seed::Api::StationTimetable::List
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info
    end

    def factory_for_seeding_fundamental_list
      ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::Fundamental::List
    end

    def factory_for_seeding_fundamental_info
      ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::Fundamental::Info
    end

    def factory_for_seeding_fundamental_info_separeted_list
      ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::Fundamental::Info::Separated::List
    end

    def factory_for_seeding_fundamental_info_separeted_info
      ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::Fundamental::Info::Separated::Info
    end

    def factory_for_seeding_train_times
      ::TokyoMetro::Factory::Seed::Api::StationTimetable::List::TrainTimes
    end

    def factory_for_seeding_train_times_in_each_station
      ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::List
    end

    def factory_for_seeding_station_train_time
      ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::Info
    end

    def factory_for_train_type
      ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::Info::TrainType
    end

    # API の情報（generate_instance が true のときの、インスタンスの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    # @return [String or Symbol]
    def method_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_generated
      :same_as
    end

    # API の情報（ハッシュの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    # @return [String or Symbol]
    def key_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_not_generated
      "owl:sameAs"
    end

    # ファイル名を作成する際に削除する部分を示す正規表現
    # @return [Regexp]
    def regexp_indicating_deleted_part_of_value_and_used_when_determine_saved_file_name
      /\Aodpt\.StationTimetable\:/
    end

    def db_instance_class
      ::StationTimetable
    end

    def db_instance_class_of_fundamental_separated_info
      ::StationTimetableFundamentalInfo
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