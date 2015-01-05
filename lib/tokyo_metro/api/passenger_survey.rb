# 駅乗降人員数 odpt:PassengerSurvey を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/railway#駅乗降人員数-odpt:PassengerSurvey
class TokyoMetro::Api::PassengerSurvey < TokyoMetro::Api::MetaClass::NotRealTime

  include ::TokyoMetro::ClassNameLibrary::Api::PassengerSurvey

  # @!group クラスメソッド - データの取得・保存

  # 駅施設情報を取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは、「odpt.PassengerSurvey:TokyoMetro.駅名.調査年」） <owl:sameAs - URL>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param survey_year [Integer] 調査年度 <odpt:surveyYear - xsd:integer>
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [::Array]
  # @example 命名ルールの例
  #  odpt:PassengerSurvey:TokyoMetro.Tokyo.2013
  def self.get( http_client ,
    id_urn: nil , same_as: nil , operator: nil , survey_year: nil ,
    perse_json: false , generate_instance: false , to_inspect: false
    )

    factory_for_getting.process( http_client , id_urn , same_as , operator , survey_year ,
      perse_json , generate_instance , to_inspect )
  end

  # 駅施設情報を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  # @param file_type [Symbol] 保存するファイルの種類【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは、「odpt.PassengerSurvey:TokyoMetro.駅名.調査年」） <owl:sameAs - URL>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param survey_year [Integer] 調査年度 <odpt:surveyYear - xsd:integer>
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [nil]
  def self.save( http_client , filename , file_type: :yaml ,
    id_urn: nil , same_as: nil , operator: nil , survey_year: nil ,
    to_inspect: to_inspect )

    data = get( http_client ,
      id_urn: id_urn , same_as: same_as , operator: operator , survey_year: survey_year ,
      perse_json: true , generate_instance: false , to_inspect: to_inspect )

    data = eval( data.to_s.gsub( /(?:\r\n|\r)/ ,"\n" ).encode( "UTF-8" ) )

    save_data( data , filename , file_type: file_type )
  end

  # @!endgroup

  class << self
    alias :generate_all_info_of_passenger_survey_from_json :generate_from_saved_json
    alias :save_datas_of_each_year :save_datas_of_each_group
  end

  # @!group テスト

  # データ取得のテスト
  # @return [nil]
  def self.get_test( http_client , survey_year: nil )
    puts "● Passenger Survey (as of #{survey_year})"
    data = get( http_client , survey_year: survey_year ,
      to_inspect: true , perse_json: true , generate_instance: true )

    ary = data.select_year( 2013 ).sort_by_passenger_journeys.reverse
    puts ary.to_strf
  end

  # @!endgroup

end