# 地物情報 ug:Poi を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/facility
# @note 地物情報 ug:Poiでは、駅出入口情報を提供する。
# @note 地物情報は必ず緯度経度情報（geo:long, geo:lat）を持ち、 /places APIを使用した地理領域絞り込み検索が可能。
class TokyoMetro::Api::Point < TokyoMetro::Api::MetaClass::Hybrid

  include ::TokyoMetro::ClassNameLibrary::Api::Point

  # @!group クラスメソッド - データの取得・保存

  # 地物情報を取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param title [String] 地物名。エレベータには「エレベータ」という文字列を含む。「出入口」の文字列の後に出口番号が続く。<dc:title - xsd:string>
  # @param category_name [String] 地物のカテゴリ（必ず「出入口」となる） <ugsrv:categoryName - xsd:string>
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [::Array]
  def self.get( http_client ,
    id_urn: nil , title: nil , category_name: nil ,
    perse_json: false , generate_instance: false , to_inspect: false )

    factory_for_getting.process( http_client , id_urn , title , category_name ,
      perse_json , generate_instance , to_inspect )
  end

  # 駅情報を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  # @param file_type [Symbol] 保存するファイルの種類【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param title [String] 地物名。エレベータには「エレベータ」という文字列を含む。「出入口」の文字列の後に出口番号が続く。<dc:title - xsd:string>
  # @param category_name [String] 地物のカテゴリ（必ず「出入口」となる） <ugsrv:categoryName - xsd:string>
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [nil]
  def self.save( http_client , filename , file_type: :yaml ,
    id_urn: nil , title: nil , category_name: nil ,
    to_inspect: to_inspect )

    data = get( http_client ,
      id_urn: id_urn , title: title , category_name: category_name ,
      perse_json: true , generate_instance: false , to_inspect: false )

    data = eval( data.to_s.gsub( /(?:\r\n|\r)/ ,"\n" ).encode( "UTF-8" ) )

    save_data( data , filename , file_type: file_type )
  end

  # @!group テスト

  # データ取得のテスト
  # @return [nil]
  def self.get_test( http_client )
    puts "● #{get_test_title}"
    ary = get( http_client , to_inspect: true , perse_json: true , generate_instance: true )
    puts ""
    puts "#{ary.length} datas"
    puts ""

    h = ary.group_by( &:station_name_in_title )
    h.keys.sort.each do | station |
      h[ station ].sort_by( &:code_in_title ).each do | point |
        puts "(#{ point.floor.to_s.rjust(2) }) #{point.category_name} #{point.title.to_s}"
      end
    end

    ary.each do | point |
      puts point.to_strf
      puts "\n" * 2
    end

  end

  # データ取得のテスト
  # @return [nil]
  def self.get_geo_test( http_client , geo_long , geo_lat , radius )
    puts "● #{get_test_title} (geo)"
    result = get_geo( http_client , geo_long , geo_lat , radius , to_inspect: true , perse_json: true , generate_instance: true )
    puts "(#{result.length})"
    result.each do | point |
      puts point.to_strf
      puts "" * 2
    end
  end

  class << self

    private

    def get_test_title
      "Point"
    end

  end

  # @!endgroup

end