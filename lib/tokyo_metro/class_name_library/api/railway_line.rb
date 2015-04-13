# 路線情報 odpt:Railway を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::RailwayLine

  extend ::ActiveSupport::Concern

  module ClassMethods

  # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:Railway
    # @return [String]
    def rdf_type
      "odpt:Railway"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_odpt_Railway.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::RailwayLine )]
    def toplevel_namespace
      ::TokyoMetro::Api::RailwayLine
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::RailwayLine::List )]
    def list_class
      ::TokyoMetro::Api::RailwayLine::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::RailwayLine::Info )]
    def info_class
      ::TokyoMetro::Api::RailwayLine::Info
    end

    def travel_time_info_class
      ::TokyoMetro::Api::RailwayLine::Info::TravelTime::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス（データ検索 API）
    # @return [Const ( ::TokyoMetro::Factory::Get::Api::DataSearch::RailwayLine )]
    def factory_for_getting
      ::TokyoMetro::Factory::Get::Api::DataSearch::RailwayLine
    end

    # API からデータを取得するための Factory Pattern クラス（地物検索 API）
    # @return [Const ( ::TokyoMetro::Factory::Get::Api::Geo::RailwayLine )]
    def factory_for_getting_geo
      ::TokyoMetro::Factory::Get::Api::Geo::RailwayLine
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::RailwayLine::EachFile )]
    def factory_for_saving_to_each_file
      ::TokyoMetro::Factory::Save::Api::RailwayLine::EachFile
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::RailwayLine::Group )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factory::Save::Api::RailwayLine::Group
    end

    def list_class_for_saving_grouped_infos
      ::TokyoMetro::Factory::Save::Api::RailwayLine::Group::List
    end

    def file_info_class_for_saving
      ::TokyoMetro::Factory::Save::Api::RailwayLine::Group::FileInfo
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::RailwayLine::Info )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Api::RailwayLine::Info
    end

    def factory_for_generating_station_order_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::RailwayLine::Info::StationOrder::Info
    end

    def factory_for_generating_travel_time_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::RailwayLine::Info::TravelTime::Info
    end

    def factory_for_generating_women_only_car_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::RailwayLine::Info::WomenOnlyCar::Info
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::RailwayLine::List )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Api::RailwayLine::List
    end

    # @!group DB に関連するクラスの情報

    # def factory_for_seeding_list_of_station_order_infos
      # ::TokyoMetro::Factory::Seed::Api::RailwayLine::List::StationOrder
    # end

    # def factory_for_seeding_station_order_in_each_railway_line
      # ::TokyoMetro::Factory::Seed::Api::RailwayLine::Info::StationOrder::List
    # end

    # def factory_for_seeding_station_order_infos
      # ::TokyoMetro::Factory::Seed::Api::RailwayLine::Info::StationOrder::Info
    # end

    def factory_for_seeding_list_of_travel_time_infos
      ::TokyoMetro::Factory::Seed::Api::RailwayLine::List::TravelTime
    end

    def factory_for_seeding_travel_time_infos_in_each_railway_line
      ::TokyoMetro::Factory::Seed::Api::RailwayLine::Info::TravelTime::List
    end

    def factory_for_seeding_travel_time_infos
      ::TokyoMetro::Factory::Seed::Api::RailwayLine::Info::TravelTime::Info
    end

    def factory_for_seeding_list_of_women_only_car_infos
      ::TokyoMetro::Factory::Seed::Api::RailwayLine::List::WomenOnlyCar
    end

    def factory_for_seeding_women_only_car_infos_in_each_railway_line
      ::TokyoMetro::Factory::Seed::Api::RailwayLine::Info::WomenOnlyCar::List
    end

    def factory_for_seeding_women_only_car_infos
      ::TokyoMetro::Factory::Seed::Api::RailwayLine::Info::WomenOnlyCar::Info
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
      /\Aodpt\.Railway\:/
    end

    def db_instance_class
      ::RailwayLine
    end

    def db_instance_class_of_travel_time_infos
      ::TravelTimeInfo
    end

    def db_instance_class_of_women_only_car_infos
      ::WomenOnlyCarInfo
    end

    # @!endgroup

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "railway_line"
    end

  end

end