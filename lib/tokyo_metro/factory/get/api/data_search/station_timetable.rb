# API から駅時刻表 odpt:StationTimetable のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factory::Get::Api::DataSearch::StationTimetable < TokyoMetro::Factory::Get::Api::MetaClass::DataSearch

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable

  # Constructor
  def initialize( id , same_as , station , railway_line , operator , railway_direction ,
      perse_json , generate_instance , to_inspect )

    super( perse_json , generate_instance , to_inspect )
    @id = id
    @same_as = same_as
    @station = station
    @railway_line = railway_line
    @operator = operator
    @railway_direction = railway_direction
  end

  # HTTPClient に送るパラメーター
  # @return [Hash]
  def parameters
    h = super
    set_parameter_send_to_api( h , "\@id" , @id , String )
    set_parameter_send_to_api( h , "owl:sameAs" , @same_as , String )
    set_parameter_send_to_api( h , "odpt:station" , @station , String )
    set_parameter_send_to_api( h , "odpt:railway" , @railway_line , String )
    set_parameter_send_to_api( h , "odpt:operator" , @operator , String )
    set_parameter_send_to_api( h , "odpt:railDirection" , @railway_direction , String )
    h
  end

  # API からデータを取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）【必須】
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定【必須】
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定【必須】
  def self.process( http_client , id , same_as , station , railway_line , operator , railway_direction ,
    perse_json , generate_instance , to_inspect )

    info = self.new( id , same_as , station , railway_line , operator , railway_direction ,
      perse_json , generate_instance , to_inspect )
    info.get_data( http_client )
  end

end