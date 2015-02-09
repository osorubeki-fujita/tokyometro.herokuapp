# 運賃 odpt:RailwayFare を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/railway#運賃-odpt:RailwayFare
# @note 2駅間の運賃を表す。
class TokyoMetro::Api::Fare < TokyoMetro::Api::MetaClass::NotRealTime

  include ::TokyoMetro::ClassNameLibrary::Api::Fare
  include ::TokyoMetro::ClassNameLibrary::Static::Fare

  # @!group クラスメソッド - データの取得・保存

  # 運賃の情報を取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは、「odpt.RailwayFare:TokyoMetro.出発駅の路線名.出発駅名.TokyoMetro.到着駅の路線名.到着駅名」） <owl:sameAs - URL>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param from_station [String] 駅間の始点駅 <odpt:fromStation - odpt:Station>
  # @param to_station [String] 駅間の終点駅 <odpt:toStation - odpt:Station>
  # @param ticket [Integer] 切符利用時の運賃 <odpt:ticketFare - xsd:integer>
  # @param child_ticket [Integer] 切符利用時の子供運賃 <odpt:childTicketFare - xsd:integer>
  # @param ic_card [Integer] ICカード利用時の運賃 <odpt:icCardFare - xsd:integer>
  # @param child_ic_card [Integer] ICカード利用時の子供運賃 <odpt:childIcCardFare - xsd:integer>
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [::Array]
  def self.get( http_client ,
    id_urn: nil , same_as: nil , operator: nil ,
    from_station: nil , to_station: nil ,
    ticket: nil , child_ticket: nil , ic_card: nil , child_ic_card: nil ,
    perse_json: false , generate_instance: false , to_inspect: false )

    factory_for_getting.process( http_client , id_urn , same_as , operator ,
      from_station , to_station ,
      ticket , child_ticket , ic_card , child_ic_card ,
      perse_json , generate_instance , to_inspect )
  end

  # 運賃の情報を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  # @param file_type [Symbol] 保存するファイルの種類【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは、「odpt.RailwayFare:TokyoMetro.出発駅の路線名.出発駅名.TokyoMetro.到着駅の路線名.到着駅名」） <owl:sameAs - URL>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param from_station [String] 駅間の始点駅 <odpt:fromStation - odpt:Station>
  # @param to_station [String] 駅間の終点駅 <odpt:toStation - odpt:Station>
  # @param ticket [Integer] 切符利用時の運賃 <odpt:ticketFare - xsd:integer>
  # @param child_ticket [Integer] 切符利用時の子供運賃 <odpt:childTicketFare - xsd:integer>
  # @param ic_card [Integer] ICカード利用時の運賃 <odpt:icCardFare - xsd:integer>
  # @param child_ic_card [Integer] ICカード利用時の子供運賃 <odpt:childIcCardFare - xsd:integer>
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [nil]
  def self.save( http_client , filename , file_type: :yaml ,
    id_urn: id_urn , same_as: same_as , operator: operator ,
    from_station: from_station , to_station: to_station ,
    ticket: ticket , child_ticket: child_ticket , ic_card: ic_card , child_ic_card: child_ic_card ,
    to_inspect: to_inspect )

    data = get( http_client ,
      id_urn: id_urn , same_as: same_as , operator: operator ,
      from_station: from_station , to_station: to_station ,
      ticket: ticket , child_ticket: child_ticket , ic_card: ic_card , child_ic_card: child_ic_card ,
      perse_json: true , generate_instance: false , to_inspect: to_inspect )

    data = eval( data.to_s.gsub( /(?:\r\n|\r)/ ,"\n" ).encode( "UTF-8" ) )

    save_data( data , filename , file_type: file_type )
  end

  class << self
    alias :generate_all_info_of_fare_from_json :generate_from_saved_json
    alias :save_datas_of_fare :save_datas_of_each_group
  end

  # @!endgroup

  # @!group テスト

  # データ取得のテスト
  # @return [nil]
  def self.get_test( http_client , from )
    puts "● Fare (from #{from})"
    data = get( http_client ,
      from_station: from , to_station: nil ,
      # id_urn: nil , same_as: nil , operator: nil ,
      # ticket: "240" ,
      # child_ticket: nil , ic_card: nil , child_ic_card: nil ,
      to_inspect: true , perse_json: true , generate_instance: true )

    puts data.sort_by_fare.to_strf
  end

  # @!endgroup

end