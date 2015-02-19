# API から取得したデータを保存するメソッドを提供するモジュール
module TokyoMetro::Modules::Api::ToFactory::Save::Info::DataSearch

  extend ::ActiveSupport::Concern

  module ClassMethods

    private

    # API からデータを取得し保存するメソッド
    # @param data [Hash or ::Array] API から取得した JSON-LD のデータを Ruby のインスタンスに変換したもの
    # @param file_type [Symbol] 保存するデータの形式
    # @param db_dir [String (dirname) or Const (Class)] 「データベースのディレクトリを示す文字列」または「クラスを表す定数」
    # @note db_dir を定義しない場合は、このモジュールが組み込まれたクラスのクラスメソッド db_dirname を呼び出す。また、クラスを表す定数が指定された場合は、指定されたクラスのクラスメソッド db_dirname が呼び出される。
    # @return [nil]
    # @note 保存されるディレクトリの名称は、それぞれのデータの種類に応じて自動的に決定する。
    # @note 保存されるファイルの名称は、API からのデータ取得開始の日時をそのまま用いる。
    def save_data( data , filename = Time.now.strftime( "%Y%m%d" ) ,
      db_dir: db_dirname ,
      dirname_sub: nil ,
      file_type: :yaml
    )
      factory_for_saving_to_each_file.process( data , filename , db_dir , dirname_sub , file_type )
    end

  end

end