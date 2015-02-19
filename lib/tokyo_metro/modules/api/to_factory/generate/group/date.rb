# 日付ごとに保存された情報を処理するメソッドを提供するモジュール
module TokyoMetro::Modules::Api::ToFactory::Generate::Group::Date

  extend ::ActiveSupport::Concern

  module ClassMethods

  # @!group 保存済みの情報を処理するメソッド

    # 保存済みの情報からインスタンスの配列を復元するメソッド
    # @param y [Integer] 情報が保存された年
    # @param m [Integer] 情報が保存された月
    # @param d [Integer] 情報が保存された日
    # @param file_type [String (filename)] ファイルの種類
    # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
    # @param max [Integer or nil] 配列の要素の最大値
    # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
    # @return [subclass of TokyoMetro::Api::MetaClass::Fundamental::List]
    def generate_from_saved_file( y , m , d , file_type: :json , db_dirname_sub: nil , max:  nil )
      factory_for_generating_from_saved_file.process( y , m , d , file_type , db_dirname , db_dirname_sub , max )
    end

    # 保存済みの JSON ファイルからインスタンスの配列を復元するメソッド
    # @param y [Integer] 情報が保存された年
    # @param m [Integer] 情報が保存された月
    # @param d [Integer] 情報が保存された日
    # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
    # @param max [Integer or nil] 配列の要素の最大値
    # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
    # @return [subclass of TokyoMetro::Api::MetaClass::Fundamental::List]
    def generate_from_saved_json( y , m , d , db_dirname_sub: nil , max: nil )
      generate_from_saved_file( y , m , d , file_type: :json , db_dirname_sub: nil , max:  nil )
    end

    # 保存済みの YAML ファイルからインスタンスの配列を復元するメソッド
    # @param y [Integer] 情報が保存された年
    # @param m [Integer] 情報が保存された月
    # @param d [Integer] 情報が保存された日
    # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
    # @param max [Integer or nil] 配列の要素の最大値
    # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
    # @return [subclass of TokyoMetro::Api::MetaClass::Fundamental::List]
    def generate_from_saved_yaml( y , m , d , db_dirname_sub: nil , max: nil )
      generate_from_saved_file( y , m , d , file_type: :yaml , db_dirname_sub: nil , max:  nil )
    end

  # @!endgroup

  end

end