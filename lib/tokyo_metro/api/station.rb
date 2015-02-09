# 駅情報 odpt:Station を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/railway#駅情報-odpt:Station
# @note 駅情報 odpt:Stationは、駅の情報を示す。この情報は国土交通省国土数値情報を元に、 施設情報や乗り換え路線などを加筆・修正したものとなる。
class TokyoMetro::Api::Station < TokyoMetro::Api::MetaClass::Hybrid

  include ::TokyoMetro::ClassNameLibrary::Api::Station

  # @!group クラスメソッド - データの取得・保存

  # 駅情報を取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは、「odpt.Station:TokyoMetro.路線名.駅名」） <owl:sameAs - URL>
  # @param title [String] 駅名 <dc:title - xsd:string>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param railway_line [String] 路線 <odpt:railway - odpt:Railway>
  # @param station_code [String] 駅コード <odpt:stationCode - xsd:string>
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [::Array]
  def self.get( http_client ,
    id_urn: nil , same_as: nil , title: nil , operator: nil , railway_line: nil , station_code: nil ,
    perse_json: false , generate_instance: false , to_inspect: false )

    factory_for_getting.process( http_client , id_urn , same_as , title , operator , railway_line , station_code ,
      perse_json , generate_instance , to_inspect )
  end

  # 駅情報を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  # @param file_type [Symbol] 保存するファイルの種類【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは、「odpt.Station:TokyoMetro.路線名.駅名」） <owl:sameAs - URL>
  # @param title [String] 駅名 <dc:title - xsd:string>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param railway_line [String] 路線 <odpt:railway - odpt:Railway>
  # @param station_code [String] 駅コード <odpt:stationCode - xsd:string>
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [nil]
  def self.save( http_client , filename , file_type: :yaml ,
    id_urn: nil , same_as: nil , title: nil , operator: nil , railway_line: nil , station_code: nil ,
    to_inspect: to_inspect )

    data = get( http_client ,
      id_urn: id_urn , same_as: same_as , title: title , operator: operator , railway_line: railway_line , station_code: station_code ,
      perse_json: true , generate_instance: false , to_inspect: false )

    # data = eval( data.to_s.gsub( /(?:\r\n|\r)/ ,"\n" ).encode( "UTF-8" ) )

    save_data( data , filename , file_type: file_type )
  end

  # @!group テスト

  # データ取得のテスト
  # @param http_client [HTTPClient]
  # @param station [String] 駅名（"xxxx.yyyy.zzzz" を指定すると、"odpt.Station:xxxx.yyyy.zzzz" の駅情報を呼び出す）
  # @return [nil]
  def self.get_test( http_client , station )
    station = "odpt.Station:#{station}"
    puts "● #{get_test_title}"
    ary = get( http_client , same_as: station , to_inspect: true , perse_json: true , generate_instance: true )
    puts "#{station} (#{ary.length})"
    puts ary.first.to_strf
  end

  # データ取得のテスト
  # @return [nil]
  def self.get_geo_test( http_client , geo_long , geo_lat , radius )
    puts "● #{get_test_title} (geo)"
    result = get_geo( http_client , geo_long , geo_lat , radius , to_inspect: true , perse_json: true , generate_instance: true )
    puts "(#{result.length})"
    result.sort_by( &:same_as ).each do | rail |
      puts rail.to_strf
      puts "" * 2
    end
  end

  # @!endgroup

  class << self

    alias :generate_all_info_of_stations_from_json :generate_from_saved_json
    alias :save_datas_of_each_station :save_datas_of_each_group

    private

    def get_test_title
      "Station"
    end

  end

end