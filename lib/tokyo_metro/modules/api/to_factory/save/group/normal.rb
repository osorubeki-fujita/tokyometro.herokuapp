# 一般の場合
module TokyoMetro::Modules::Api::ToFactory::Save::Group::Normal

  extend ::ActiveSupport::Concern

  module ClassMethods

    # API からの情報を取得し、ディレクトリに分けて保存するメソッド
    # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
    # @param file_type [Symbol] 保存するファイルの種類【必須】
    # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
    # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
    # @return [nil]
    # @note 作成するディレクトリの設定 [Symbol or nil] は Factory Pattern の各クラスで定義する。
    def save_datas_of_each_group( http_client , file_type: :yaml , generate_instance: false , to_inspect: true )
      factory_for_saving_datas_of_each_group.process( http_client , db_dirname , file_type , generate_instance , to_inspect )
    end

  end

end