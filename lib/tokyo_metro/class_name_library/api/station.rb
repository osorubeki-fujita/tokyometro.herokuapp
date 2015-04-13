# 駅情報 odpt:Station を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::Station

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:Station
    # @return [String]
    def rdf_type
      "odpt:Station"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_odpt_Station.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::Station )]
    def toplevel_namespace
      ::TokyoMetro::Api::Station
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::Station::List )]
    def list_class
      ::TokyoMetro::Api::Station::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::Station::Info )]
    def info_class
      ::TokyoMetro::Api::Station::Info
    end

    def connecting_railway_line_list_class
      ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::List
    end

    def connecting_railway_line_info_class
      ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info
    end

    def exit_list_class
      ::TokyoMetro::Api::Station::Info::Exit::List
    end

    def exit_info_class
      ::TokyoMetro::Api::Station::Info::Exit::Info
    end

    def link_to_passenger_survey_list_class
      ::TokyoMetro::Api::Station::Info::LinkToPassengerSurvey::List
    end

    def link_to_passenger_survey_info_class
      ::TokyoMetro::Api::Station::Info::LinkToPassengerSurvey::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス（データ検索 API）
    # @return [Const ( ::TokyoMetro::Factory::Get::Api::DataSearch::Station )]
    def factory_for_getting
      ::TokyoMetro::Factory::Get::Api::DataSearch::Station
    end

    # API からデータを取得するための Factory Pattern クラス（地物検索 API）
    # @return [Const ( ::TokyoMetro::Factory::Get::Api::Geo::Station )]
    def factory_for_getting_geo
      ::TokyoMetro::Factory::Get::Api::Geo::Station
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::Station::EachFile )]
    def factory_for_saving_to_each_file
      ::TokyoMetro::Factory::Save::Api::Station::EachFile
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::Station::Group )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factory::Save::Api::Station::Group
    end

    def list_class_for_saving_grouped_infos
      ::TokyoMetro::Factory::Save::Api::Station::Group::List
    end

    def file_info_class_for_saving
      ::TokyoMetro::Factory::Save::Api::Station::Group::FileInfo
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::Station::Info )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Api::Station::Info
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::Station::List )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Api::Station::List
    end

    def factory_for_generating_connecting_railway_from_string
      ::TokyoMetro::Factory::Generate::Api::Station::Info::ConnectingRailwayLine::Info
    end

    def factory_for_generating_exit_from_string
      ::TokyoMetro::Factory::Generate::Api::Station::Info::Exit::Info
    end

    def factory_for_generating_link_to_passenger_survey_from_string
      ::TokyoMetro::Factory::Generate::Api::Station::Info::LinkToPassengerSurvey::Info
    end

    # @!group DB

    def factory_for_seeding_list
      ::TokyoMetro::Factory::Seed::Api::Station::List
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Api::Station::Info
    end

    def factory_for_seeding_connecting_railway_lines
      ::TokyoMetro::Factory::Seed::Api::Station::List::ConnectingRailwayLine
    end

    def factory_for_seeding_connecting_railway_lines_of_each_station
      ::TokyoMetro::Factory::Seed::Api::Station::Info::ConnectingRailwayLine::List
    end

    def factory_for_seeding_connecting_railway_line_info
      ::TokyoMetro::Factory::Seed::Api::Station::Info::ConnectingRailwayLine::Info
    end

    def factory_for_seeding_exits
      ::TokyoMetro::Factory::Seed::Api::Station::List::Exit
    end

    def factory_for_seeding_exits_of_each_station
      ::TokyoMetro::Factory::Seed::Api::Station::Info::Exit::List
    end

    def factory_for_seeding_exit
      ::TokyoMetro::Factory::Seed::Api::Station::Info::Exit::Info
    end

    def factory_for_seeding_link_to_passenger_surveys
      ::TokyoMetro::Factory::Seed::Api::Station::List::LinkToPassengerSurvey
    end

    def factory_for_seeding_link_to_passenger_surveys_of_each_station
      ::TokyoMetro::Factory::Seed::Api::Station::Info::LinkToPassengerSurvey::List
    end

    def factory_for_seeding_link_to_passenger_survey
      ::TokyoMetro::Factory::Seed::Api::Station::Info::LinkToPassengerSurvey::Info
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
      /\Aodpt\.Station\:/
    end

    def db_instance_class
      ::Station
    end

    def db_instance_class_of_connecting_railway_line
      ::ConnectingRailwayLine
    end

    def db_instance_class_of_exit
      ::StationPoint
    end

    def db_instance_class_of_link_to_passenger_survey
      ::StationPassengerSurvey
    end

    # @!endgroup

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "station"
    end

  end

end