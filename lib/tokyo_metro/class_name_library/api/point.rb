# 地物情報 ug:Poi を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::Point

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - ug:Poi
    # @return [String]
    def rdf_type
       "ug:Poi"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_ug_Poi.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::Point )]
    def toplevel_namespace
      ::TokyoMetro::Api::Point
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::Point::List )]
    def list_class
      ::TokyoMetro::Api::Point::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::Point::Info )]
    def info_class
      ::TokyoMetro::Api::Point::Info
    end

    def title_class
      ::TokyoMetro::Api::Point::Info::Title
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス（データ検索 API）
    # @return [Const ( ::TokyoMetro::Factory::Get::Api::DataSearch::Point )]
    def factory_for_getting
      ::TokyoMetro::Factory::Get::Api::DataSearch::Point
    end

    # API からデータを取得するための Factory Pattern クラス（地物検索 API）
    # @return [Const ( ::TokyoMetro::Factory::Get::Api::Geo::Point )]
    def factory_for_getting_geo
      ::TokyoMetro::Factory::Get::Api::Geo::Point
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::Point::EachFile )]
    def factory_for_saving_to_each_file
      ::TokyoMetro::Factory::Save::Api::Point::EachFile
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::Point::Group )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factory::Save::Api::Point::Group
    end

    def list_class_for_saving_grouped_infos
      ::TokyoMetro::Factory::Save::Api::Point::Group::List
    end

    def file_info_class_for_saving
      ::TokyoMetro::Factory::Save::Api::Point::Group::FileInfo
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::Point::Info )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Api::Point::Info
    end

    def factory_for_generating_title_from_hash
      ::TokyoMetro::Factory::Generate::Api::Point::Info::Title
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::Point::List )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Api::Point::List
    end

    def factory_for_seeding_list
      ::TokyoMetro::Factory::Seed::Api::Point::List
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Api::Point::Info
    end

    # API の情報（generate_instance が true のときの、インスタンスの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    # @return [String or Symbol]
    def method_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_generated
      :station
    end

    # API の情報（ハッシュの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    # @return [String or Symbol]
    def key_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_not_generated
      "owl:sameAs"
    end

    # ファイル名を作成する際に削除する部分を示す正規表現
    # @return [Regexp]
    def regexp_indicating_deleted_part_of_value_and_used_when_determine_saved_file_name
      /\odpt\.StationFacility\:/
    end

    def db_instance_class
      ::Point
    end

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "point"
    end

  end

end