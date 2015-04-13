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
    # @return [Const ( ::TokyoMetro::Factory::Get::Api::DataSearch::TrainLocation )]
    def factory_for_getting
      ::TokyoMetro::Factory::Get::Api::DataSearch::TrainLocation
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::TrainLocation::EachFile )]
    def factory_for_saving_to_each_file
      ::TokyoMetro::Factory::Save::Api::TrainLocation::EachFile
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::TrainLocation::Group )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factory::Save::Api::TrainLocation::Group
    end

    def list_class_for_saving_grouped_infos
      ::TokyoMetro::Factory::Save::Api::TrainLocation::Group::List
    end

    def file_info_class_for_saving
      ::TokyoMetro::Factory::Save::Api::TrainLocation::Group::FileInfo
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::TrainLocation::Info )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Api::TrainLocation::Info
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::TrainLocation::List )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Api::TrainLocation::List
    end

    # API の情報（generate_instance が true のときの、インスタンスの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    # @return [String or Symbol]
    def method_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_generated
      :railway_line
    end

    # API の情報（ハッシュの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    # @return [String or Symbol]
    def key_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_not_generated
      "odpt:railway"
    end

    # ファイル名を作成する際に削除する部分を示す正規表現
    # @return [Regexp]
    def regexp_indicating_deleted_part_of_value_and_used_when_determine_saved_file_name
      /\Aodpt\.Railway\:/
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