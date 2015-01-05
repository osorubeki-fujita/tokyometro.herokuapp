# 列車運行情報 odpt:TrainInformation を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/railway#列車運行情報-odpt:TrainInformation
# @note 列車運行情報を示す。基本的に発生時刻、発生箇所、現在状況を示す。
# @note 平常運転時でも「平常」などの文字列を含んだ文字列を返す。 
# @note 平常時かそれ以外かは、odpt:trainInformationStatus プロパティの存在有無で判定可能である。
class TokyoMetro::Api::TrainInformation < TokyoMetro::Api::MetaClass::RealTime

  include ::TokyoMetro::ClassNameLibrary::Api::TrainInformation

  # @!group クラスメソッド - データの取得・保存

  # 列車運行情報を取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param railway_line [String] 発生路線 <odpt:railway - odpt:Railway>
  # @param information_status [String] 運行ステータス <odpt:trainInformationStatus - xsd:string>
  # @param information_text [String] 運行情報テキスト <odpt:trainInformationText - xsd:string>
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @note 運行ステータスは、平常時は省略。運行情報が存在する場合は「運行情報あり」を格納。遅延などの情報を取得可能な場合は、「遅延」等のテキストを格納。
  # @return [::Array]
  def self.get( http_client ,
    id_urn: nil , operator: nil , railway_line: nil , information_status: nil , information_text: nil ,
    perse_json: false , generate_instance: false , to_inspect: false )

    factory_for_getting.process( http_client , id_urn , operator , railway_line , information_status , information_text ,
      perse_json , generate_instance , to_inspect )
  end

  # 列車運行情報を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  # @param file_type [Symbol] 保存するファイルの種類【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param railway_line [String] 発生路線 <odpt:railway - odpt:Railway>
  # @param information_status [String] 運行ステータス <odpt:trainInformationStatus - xsd:string>
  # @param information_text [String] 運行情報テキスト <odpt:trainInformationText - xsd:string>
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @note 運行ステータスは、平常時は省略。運行情報が存在する場合は「運行情報あり」を格納。遅延などの情報を取得可能な場合は、「遅延」等のテキストを格納。
  # @return [nil]
  def self.save( http_client , filename , file_type: :yaml ,
    id_urn: nil , operator: nil , railway_line: nil , information_status: nil , information_text: nil ,
    to_inspect: to_inspect )

    data = get( http_client ,
      id_urn: id_urn , operator: operator , railway_line: railway_line , information_status: information_status , information_text: information_text ,
      perse_json: true , generate_instance: false , to_inspect: to_inspect )

    # data = eval( data.to_s.gsub( /(?:\r\n|\r)/ ,"\n" ).encode( "UTF-8" ) )

    save_data( data , filename , file_type: file_type )
  end

  # @!group テスト

  # データ取得のテスト
  # @return [nil]
  def self.get_test( http_client )
    puts "● Train information"
    puts ""
    tran_info = get( http_client , to_inspect: true , perse_json: true , generate_instance: true )
    puts tran_info.sort_by_railway_line_order.to_strf
    puts "\n" * 3
  end

  # @!endgroup

end