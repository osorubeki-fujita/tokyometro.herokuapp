# データを保存するディレクトリの情報に関するメソッドを組み込むためのモジュール
module TokyoMetro::ApiModules::Common::DbDirname

  extend ::ActiveSupport::Concern

  module ClassMethods

    private

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname
      "#{::TokyoMetro::DB_DIR}/#{db_dirname_sub}"
    end

  end

end