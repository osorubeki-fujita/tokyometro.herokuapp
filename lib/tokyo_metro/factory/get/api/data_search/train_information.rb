# API から列車運行情報 odpt:TrainInformation のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factory::Get::Api::DataSearch::TrainInformation < TokyoMetro::Factory::Get::Api::MetaClass::DataSearch

  include ::TokyoMetro::ClassNameLibrary::Api::TrainInformation

  # Constructor
  def initialize( id , operator , railway_line , information_status , information_text ,
    perse_json , generate_instance , to_inspect )

    super( perse_json , generate_instance , to_inspect )
    @id = id
    @operator = operator
    @railway_line = railway_line
    @information_status = information_status
    @information_text = information_text
  end

  # HTTPClient に送るパラメーター
  # @return [Hash]
  def parameters
    h = super
    set_parameter_send_to_api( h , "\@id" , @id , String )
    set_parameter_send_to_api( h , "owl:operator" , @operator , String )
    set_parameter_send_to_api( h , "odpt:railway" , @railway_line , String )
    set_parameter_send_to_api( h , "odpt:trainInformationStatus" , @information_status , String )
    set_parameter_send_to_api( h , "odpt:trainInformationText" , @information_text , String )
    h
  end

  # API からデータを取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）【必須】
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定【必須】
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定【必須】
  def self.process( http_client , id , operator , railway_line , information_status , information_text ,
    perse_json , generate_instance , to_inspect )

    info = self.new( id , operator , railway_line , information_status , information_text ,
      perse_json , generate_instance , to_inspect )
    info.get_data( http_client )
  end

end