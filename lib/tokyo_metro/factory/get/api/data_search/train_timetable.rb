# API から列車時刻表 odpt:TrainTimetable のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factory::Get::Api::DataSearch::TrainTimetable < TokyoMetro::Factory::Get::Api::MetaClass::DataSearch

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  # Constructor
  def initialize( http_client , id_urn , same_as , train_number , railway_line ,
      operator , train_type , railway_direction ,
      starting_station , terminal_station , train_owner , train ,
      perse_json , generate_instance , to_inspect )

    super( perse_json , generate_instance , to_inspect )
    @id_urn = id_urn
    @same_as = same_as
    @train_number = train_number
    @railway_line = railway_line
    @operator = operator
    @train_type = train_type
    @railway_direction = railway_direction

    @starting_station = starting_station
    @terminal_station = terminal_station
    @train_owner = train_owner
    @train = train
  end

  # HTTPClient に送るパラメーター
  # @return [Hash]
  def parameters
    h = super
    set_parameter_send_to_api( h , "\@id" , @id_urn , String )
    set_parameter_send_to_api( h , "owl:sameAs" , @same_as , String )
    set_parameter_send_to_api( h , "odpt:trainNumber" , @train_number , String )
    set_parameter_send_to_api( h , "odpt:railway" , @railway_line , String )
    set_parameter_send_to_api( h , "odpt:operator" , @operator , String )
    set_parameter_send_to_api( h , "odpt:trainType" , @train_type , String )
    set_parameter_send_to_api( h , "odpt:railDirection" , @railway_direction , String )

    set_parameter_send_to_api( h , "odpt:startingStation" , @starting_station , String )
    set_parameter_send_to_api( h , "odpt:terminalStation" , @terminal_station , String )
    set_parameter_send_to_api( h , "odpt:trainOwner" , @train_owner , String )
    set_parameter_send_to_api( h , "odpt:train" , @train , String )
    h
  end

  # API からデータを取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）【必須】
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定【必須】
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定【必須】
  def self.process( http_client , id_urn , same_as , train_number , railway_line ,
      operator , train_type , railway_direction ,
      starting_station , terminal_station , train_owner , train ,
      perse_json , generate_instance , to_inspect )

    info = self.new( http_client , id_urn , same_as , train_number , railway_line ,
      operator , train_type , railway_direction ,
      starting_station , terminal_station , train_owner , train ,
      perse_json , generate_instance , to_inspect )
    info.get_data( http_client )
  end

end