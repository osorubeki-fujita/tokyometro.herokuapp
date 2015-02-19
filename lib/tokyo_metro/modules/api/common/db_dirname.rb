# データを保存するディレクトリの情報に関するメソッドを組み込むためのモジュール
# @note データ検索 API を利用するクラス、地理情報 API を利用するクラスに共通するクラスメソッド
# @note {TokyoMetro::Api::MetaClass::Fundamental} に include する。
# @note ActiveSupport::Concern を利用している。
module TokyoMetro::Modules::Api::Common::DbDirname

  extend ::ActiveSupport::Concern

  module ClassMethods

    private

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname
      "#{::TokyoMetro.db_dir}/#{db_dirname_sub}"
    end

  end

end