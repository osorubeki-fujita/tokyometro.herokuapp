# API から駅施設情報 odpt:StationFacility のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factory::Get::Api::DataSearch::StationFacility < TokyoMetro::Factory::Get::Api::MetaClass::DataSearch

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  # Constructor
  def initialize( id , same_as ,
    perse_json , generate_instance , to_inspect )

    super( perse_json , generate_instance , to_inspect )
    # puts "(2) #{ self.class.name }\##{__method__}"
    @id = id
    @same_as = same_as
  end

  # HTTPClient に送るパラメーター
  # @return [Hash]
  def parameters
    h = super

    # puts "-" * 96
    # puts "(11) TokyoMetro::Factory::Get::Api::DataSearch::StationFacility\##{__method__}"

    set_parameter_send_to_api( h , "\@id" , @id , String )
    set_parameter_send_to_api( h , "owl:sameAs" , @same_as , String )
    # puts "(12) TokyoMetro::Factory::Get::Api::DataSearch::StationFacility\##{__method__}"

    h
  end

  # API からデータを取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）【必須】
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定【必須】
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定【必須】
  def self.process( http_client , id , same_as ,
    perse_json , generate_instance , to_inspect )

    # puts "(1) #{ self.name }.#{__method__}"

    info = self.new( id , same_as ,
      perse_json , generate_instance , to_inspect )

    # puts "Initialize is finishied."
    # puts ""

    info.get_data( http_client )
  end

end