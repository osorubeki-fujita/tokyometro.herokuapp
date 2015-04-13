# API から駅乗降人員数 odpt:PassengerSurvey のデータを取得するための Factory Pattern のクラス
class TokyoMetro::Factory::Get::Api::DataSearch::PassengerSurvey < TokyoMetro::Factory::Get::Api::MetaClass::DataSearch

  include ::TokyoMetro::ClassNameLibrary::Api::PassengerSurvey

  # Constructor
  def initialize( id , same_as , operator , survey_year ,
      perse_json , generate_instance , to_inspect )

    super( perse_json , generate_instance , to_inspect )

    @id = id
    @same_as = same_as
    @operator = operator
    @survey_year = survey_year
  end

  # HTTPClient に送るパラメーター
  # @return [Hash]
  def parameters
    h = super
    set_parameter_send_to_api( h , "\@id" , @id , String )
    set_parameter_send_to_api( h , "owl:sameAs" , @same_as , String )
    set_parameter_send_to_api( h , "odpt:operator" , @operator , String )
    set_parameter_send_to_api( h , "odpt:surveyYear" , @survey_year , Integer )
    h
  end

  # API からデータを取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）【必須】
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定【必須】
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定【必須】
  def self.process( http_client , id , same_as , operator , survey_year ,
      perse_json , generate_instance , to_inspect )

    info = self.new( id , same_as , operator , survey_year ,
      perse_json , generate_instance , to_inspect )

    info.get_data( http_client )
  end

end