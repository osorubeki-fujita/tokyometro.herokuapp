# API から地物情報 ug:Poi のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factory::Get::Api::DataSearch::Point < TokyoMetro::Factory::Get::Api::MetaClass::DataSearch

  include ::TokyoMetro::ClassNameLibrary::Api::Point

  # Constructor
  def initialize( id , title , category_name ,
    perse_json , generate_instance , to_inspect )

    super( perse_json , generate_instance , to_inspect )
    @id = id
    @title = title
    @category_name = category_name
  end

  # HTTPClient に送るパラメーター
  # @return [Hash]
  def parameters
    h = super

    set_parameter_send_to_api( h , "\@id" , @id , String )
    set_parameter_send_to_api( h , "dc:title" , @title , String )
    set_parameter_send_to_api( h , "ugsrv:categoryName" , @category_name , String )

    h
  end

  # API からデータを取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）【必須】
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定【必須】
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定【必須】
  def self.process( http_client , id , title , category_name ,
    perse_json , generate_instance , to_inspect )

    info = self.new( id , title , category_name ,
      perse_json , generate_instance , to_inspect )
    info.get_data( http_client )
  end

end