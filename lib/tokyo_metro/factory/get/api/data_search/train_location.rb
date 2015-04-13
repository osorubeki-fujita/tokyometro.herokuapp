# API から列車ロケーション情報 odpt:Train のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factory::Get::Api::DataSearch::TrainLocation < TokyoMetro::Factory::Get::Api::MetaClass::DataSearch

  include ::TokyoMetro::ClassNameLibrary::Api::TrainLocation

  # Constructor
  def initialize( railway_line , id , same_as , train_number , train_type , train_owner , railway_direction , delay ,
    starting_station , terminal_station , from_station , to_station ,
    perse_json , generate_instance , to_inspect )

    super( perse_json , generate_instance , to_inspect )
    @railway_line = railway_line

    @id = id
    @same_as = same_as
    @train_number = train_number
    @train_type = train_type
    @train_owner = train_owner
    @railway_direction = railway_direction
    @delay = delay
    @starting_station = starting_station
    @terminal_station = terminal_station
    @from_station = from_station
    @to_station = to_station
  end

  # HTTPClient に送るパラメーター
  # @return [Hash]
  def parameters
    h = super

    h[ "odpt:railway" ] = @railway_line

    set_parameter_send_to_api( h , "\@id" , @id , String )
    set_parameter_send_to_api( h , "owl:sameAs" , @same_as , String )
    set_parameter_send_to_api( h , "odpt:trainNumber" , @train_number , String )
    set_parameter_send_to_api( h , "odpt:trainType" , @train_type , String )

    set_parameter_send_to_api( h , "odpt.trainOwner" , @train_owner , String )
    set_parameter_send_to_api( h , "odpt:railDirection" , @railway_direction , String )

    set_parameter_send_to_api( h , "odpt:delay" , @delay , Integer )
    set_parameter_send_to_api( h , "odpt:startingStation" , @starting_station , String )
    set_parameter_send_to_api( h , "odpt:terminalStation" , @terminal_station , String )
    set_parameter_send_to_api( h , "odpt:fromStation" , @from_station , String )
    set_parameter_send_to_api( h , "odpt:toStation" , @to_station , String )

    h
  end

  # API からデータを取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）【必須】
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定【必須】
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定【必須】
  def self.process( http_client , railway_line , id , same_as , train_number , train_type , train_owner , railway_direction , delay ,
    starting_station , terminal_station , from_station , to_station ,
    perse_json , generate_instance , to_inspect )

    info = self.new( railway_line , id , same_as , train_number , train_type , train_owner , railway_direction , delay ,
      starting_station , terminal_station , from_station , to_station ,
      perse_json , generate_instance , to_inspect )

    info.get_data( http_client )
  end

end