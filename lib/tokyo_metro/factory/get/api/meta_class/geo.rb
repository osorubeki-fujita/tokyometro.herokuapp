# API からデータを取得するための Factory Pattern のクラス（地物検索 API を利用する場合）
class TokyoMetro::Factory::Get::Api::MetaClass::Geo < TokyoMetro::Factory::Get::Api::MetaClass::Fundamental

  def initialize( long , lat , radius , perse_json , generate_instance , to_inspect )
    super( perse_json , generate_instance , to_inspect )

    @long = long
    @lat = lat
    @radius = radius
  end

  # パラメータを格納したハッシュを取得するメソッド
  # @return [Hash]
  def parameters
    super.merge(  { "lon" => @long.to_s , "lat" => @lat.to_s , "radius" => @radius.to_s } )
  end

  # @!group クラスメソッド - データの取得・保存（地物情報検索 API から）

  # 地物情報検索 API からデータを取得するメソッド（クラスメソッド）
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param long [Numeric] 検索範囲の中心点の経度（10進表記）【必須】
  # @param lat [Numeric] 検索範囲の中心点の緯度（10進表記）【必須】
  # @param radius [Numeric] 検索範囲の半径 (m)【必須】
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）【必須】
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定【必須】
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定【必須】
  def self.process( http_client , long , lat , radius , perse_json , generate_instance , to_inspect )
    self.new( long , lat , radius , perse_json , generate_instance , to_inspect ).get_data( http_client )
  end

  private

  def check_validity_of_settings( http_client )
    super( http_client )
    raise "Error" unless @long.number?
    raise "Error" unless @lat.number?
    raise "Error" unless @radius.number?
  end

  def access_point_url
    ::TokyoMetro::PLACES_URL
  end

end