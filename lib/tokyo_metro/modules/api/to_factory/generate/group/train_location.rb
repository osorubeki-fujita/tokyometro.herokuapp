# 保存済みの列車ロケーション情報を処理するメソッドを提供するモジュール
module TokyoMetro::Modules::Api::ToFactory::Generate::Group::TrainLocation

  extend ::ActiveSupport::Concern

  module ClassMethods

  # @!group 保存済みの情報を処理するメソッド

    # 保存済みの情報からインスタンスの配列を復元するメソッド
    # @param railway_line [String] 列車ロケーション情報の路線名
    # @param y [Integer] 情報が保存された年
    # @param m [Integer] 情報が保存された月
    # @param d [Integer] 情報が保存された日
    # @param file_type [String (filename)] ファイルの種類
    # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
    # @param max [Integer or nil] 配列の要素の最大値
    # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
    # @return [TokyoMetro::Api::TrainLocation::List]
    def generate_from_saved_file( y , m , d , railway_line: nil , file_type: :json , db_dirname_sub: nil , max: nil )
      factory_for_generating_from_saved_file.process( y , m , d , railway_line , file_type , db_dirname , db_dirname_sub , max )
    end

    # 保存済みの JSON ファイルからインスタンスの配列を復元するメソッド
    # @param y [Integer] 情報が保存された年
    # @param m [Integer] 情報が保存された月
    # @param d [Integer] 情報が保存された日
    # @param railway_line [String] 列車ロケーション情報の路線名
    # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
    # @param max [Integer or nil] 配列の要素の最大値
    # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
    # @return [TokyoMetro::Api::TrainLocation::List]
    def generate_from_saved_json( y , m , d , railway_line: nil , db_dirname_sub: nil , max: nil )
      generate_from_saved_file( y , m , d ,
        railway_line: railway_line , db_dirname_sub: db_dirname_sub ,
        file_type: :json , max: max )
    end

    # 保存済みの YAML ファイルからインスタンスの配列を復元するメソッド
    # @param y [Integer] 情報が保存された年
    # @param m [Integer] 情報が保存された月
    # @param d [Integer] 情報が保存された日
    # @param railway_line [String] 列車ロケーション情報の路線名
    # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
    # @param max [Integer or nil] 配列の要素の最大値
    # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
    # @return [TokyoMetro::Api::TrainLocation::List]
    def generate_from_saved_yaml( y , m , d , railway_line: nil , db_dirname_sub: nil , max: nil )
      generate_from_saved_file( y , m , d ,
        railway_line: railway_line , db_dirname_sub: db_dirname_sub ,
        file_type: :yaml , max: max )
    end

  # @!endgroup

  end

end