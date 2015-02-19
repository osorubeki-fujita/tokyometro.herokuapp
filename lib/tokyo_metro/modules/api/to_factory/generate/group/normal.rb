# 保存済みの情報を処理するメソッドを提供するモジュール（一般）
module TokyoMetro::Modules::Api::ToFactory::Generate::Group::Normal

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group 保存済みの情報を処理するメソッド

    # 保存済みの情報からインスタンスの配列を復元するメソッド
    # @param file_type [String (filename)] ファイルの種類
    # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
    # @param max [Integer or nil] 配列の要素の最大値
    # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
    # @return [subclass of TokyoMetro::Api::MetaClass::Fundamental::List]
    def generate_from_saved_file( file_type: :json , db_dirname_sub: nil , max: nil )
      factory_for_generating_from_saved_file.process( file_type , db_dirname , db_dirname_sub , max )
    end

    # 保存済みの JSON ファイルからインスタンスの配列を復元するメソッド
    # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
    # @param max [Integer or nil] 配列の要素の最大値
    # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
    # @return [subclass of TokyoMetro::Api::MetaClass::Fundamental::List]
    def generate_from_saved_json( db_dirname_sub: nil , max: nil )
      generate_from_saved_file( db_dirname_sub: nil , file_type: :json , max: max )
    end

    # 保存済みの YAML ファイルからインスタンスの配列を復元するメソッド
    # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
    # @param max [Integer or nil] 配列の要素の最大値
    # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
    # @return [subclass of TokyoMetro::Api::MetaClass::Fundamental::List]
    def generate_from_saved_yaml( db_dirname_sub: nil , max: nil )
      generate_from_saved_file( db_dirname_sub: nil , file_type: :yaml , max: max )
    end

    # @!group Factory Pattern のクラスの情報

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const (class)]
    # @raise [RuntimeError] サブクラスで定義するため、このクラスでは例外が発生するようにしている。
    def factory_for_generating_from_saved_file
      raise "The class method \"#{__method__}\" is not defined yet in this class."
    end

    # @!endgroup

  end

end