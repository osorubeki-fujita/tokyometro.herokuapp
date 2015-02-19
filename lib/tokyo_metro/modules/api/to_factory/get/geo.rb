# API からデータを取得するメソッドを提供するモジュール
module TokyoMetro::Modules::Api::ToFactory::Get::Geo

  extend ::ActiveSupport::Concern

  module ClassMethods

    # 地物情報検索 API からデータを取得するメソッド
    # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
    # @param long [Numeric] 検索範囲の中心点の経度（10進表記）【必須】
    # @param lat [Numeric] 検索範囲の中心点の緯度（10進表記）【必須】
    # @param radius [Numeric] 検索範囲の半径 (m)【必須】
    # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
    # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
    # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
    # @return [::Array <Hash>] perse_json が true の場合は、JSON を配列に変換して返す。
    # @return [String] perse_json が false の場合は、JSON を文字列として返す。
    def get_geo( http_client , long , lat , radius , perse_json: false , generate_instance: false , to_inspect: false )
      factory_for_getting_geo.process( http_client , long , lat , radius ,
        perse_json , generate_instance , to_inspect )
    end

    # 地物情報検索 API からデータを取得するための Factory Pattern クラス
    # @return [Const (class)]
    # @raise [RuntimeError] サブクラスで定義するため、このクラスでは例外が発生するようにしている。
    def factory_for_getting_geo
      "The class method \"#{__method__}\" is not defined yet in this class."
    end

  end

end