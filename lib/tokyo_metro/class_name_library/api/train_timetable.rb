# 列車時刻表 odpt:TrainTimetable を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  extend ::ActiveSupport::Concern
  include ::TokyoMetro::ClassNameLibrary::Api::StationTrainTime::Db

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

    def previous_train_list_class
      ::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Previous::List
    end

    def previous_train_info_class
      ::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Previous::Info
    end

    def following_train_list_class
      ::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Following::List
    end

    def following_train_info_class
      ::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Following::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Get::Api::DataSearch::TrainTimetable )]
    def factory_for_getting
      ::TokyoMetro::Factory::Get::Api::DataSearch::TrainTimetable
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::TrainTimetable::EachFile )]
    def factory_for_saving_to_each_file
      ::TokyoMetro::Factory::Save::Api::TrainTimetable::EachFile
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::TrainTimetable::Group )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factory::Save::Api::TrainTimetable::Group
    end

    def list_class_for_saving_grouped_infos
      ::TokyoMetro::Factory::Save::Api::TrainTimetable::Group::List
    end

    def file_info_class_for_saving
      ::TokyoMetro::Factory::Save::Api::TrainTimetable::Group::FileInfo
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::TrainTimetable::Info )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Api::TrainTimetable::Info
    end

    def factory_for_generating_station_time_from_hash
      ::TokyoMetro::Factory::Generate::Api::TrainTimetable::Info::StationTime::Info
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::TrainTimetable::List )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Api::TrainTimetable::List
    end

    def factory_for_seeding_list
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::List
    end

    def factory_for_seeding_train_relations
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::List::TrainRelations
    end

    def factory_for_seeding_arrival_times_of_romance_car
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::List::ArrivalTimes::RomanceCar
    end

    def factory_for_seeding_arrival_times_of_last_station_in_tokyo_metro
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::List::ArrivalTimes::LastStationInTokyoMetro
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info
    end

    def factory_for_seeding_each_train_relation
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::TrainRelations
    end

    def factory_for_seeding_each_arrival_time_of_romance_car
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::ArrivalTimes::RomanceCar
    end

    def factory_for_seeding_each_arrival_time_of_last_station_in_tokyo_metro
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::ArrivalTimes::LastStationInTokyoMetro
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
      /\Aodpt\.TrainTimetable\:/
    end

    def db_instance_class
      ::TrainTimetable
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