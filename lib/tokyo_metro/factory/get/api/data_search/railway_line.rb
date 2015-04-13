# API から鉄道路線情報 odpt:Railway のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factory::Get::Api::DataSearch::RailwayLine < TokyoMetro::Factory::Get::Api::MetaClass::DataSearch

  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine

  # Constructor
  def initialize( id , same_as , title , operator , railway_line_code ,
    perse_json , generate_instance , to_inspect )

    super( perse_json , generate_instance , to_inspect )
    @id = id
    @same_as = same_as
    @title = title
    @operator = operator
    @railway_line_code = railway_line_code
  end

  # HTTPClient に送るパラメーター
  # @return [Hash]
  def parameters
    h = super

    set_parameter_send_to_api( h , "\@id" , @id , String )
    set_parameter_send_to_api( h , "owl:sameAs" , @same_as , String )
    set_parameter_send_to_api( h , "dc:title" , @title , String )
    set_parameter_send_to_api( h , "odpt:operator" , @operator , String )
    set_parameter_send_to_api( h , "odpt:lineCode" , @railway_line_code , String )
    h
  end

  # API からデータを取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）【必須】
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定【必須】
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定【必須】
  def self.process( http_client , id , same_as , title , operator , railway_line_code ,
    perse_json , generate_instance , to_inspect )

    info = self.new( id , same_as , title , operator , railway_line_code ,
      perse_json , generate_instance , to_inspect )

    info.get_data( http_client )
  end

end