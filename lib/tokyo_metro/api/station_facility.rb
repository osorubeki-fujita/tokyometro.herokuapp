# 駅施設情報 odpt:StationFacility を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/railway#駅施設情報-odpt:StationFacility
# @note 駅の施設に関する情報を記述する。
class TokyoMetro::Api::StationFacility < TokyoMetro::Api::MetaClass::NotRealTime

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  # @!group クラスメソッド - データの取得・保存

  # 駅施設情報を取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは、「odpt.StationFacility:TokyoMetro.駅名」） <owl:sameAs - URL>
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [::Array]
  def self.get( http_client ,
    id_urn: nil , same_as: nil ,
    perse_json: false , generate_instance: false , to_inspect: false )

    factory_for_getting.process( http_client , id_urn , same_as ,
      perse_json , generate_instance , to_inspect )
  end

  # 駅施設情報を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  # @param file_type [Symbol] 保存するファイルの種類【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは、「odpt.StationFacility:TokyoMetro.駅名」） <owl:sameAs - URL>
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [nil]
  def self.save( http_client , filename , file_type: :yaml ,
    id_urn: nil , same_as: nil ,
    to_inspect: to_inspect )

    data = get( http_client ,
      id_urn: id_urn , same_as: same_as ,
      perse_json: true , generate_instance: false , to_inspect: to_inspect )

    data = eval( data.to_s.gsub( /(?:\r\n|\r)/ ,"\n" ).encode( "UTF-8" ) )

    save_data( data , filename , file_type: file_type )
  end

  class << self
    alias :generate_all_info_of_station_facilities_from_json :generate_from_saved_json
    alias :save_datas_of_facilities_in_each_station :save_datas_of_each_group
  end

  # @!group テスト

  # データ取得のテスト
  # @param http_client [HTTPClient]
  # @param station [String] 駅名（"xxxx.yyyy" を指定すると、"odpt.StationFacility:xxxx.yyyy" の駅情報を呼び出す）
  # @return [nil]
  def self.get_test( http_client , station )
    puts "● Station Facility"
    station = "odpt.StationFacility:#{station}"
    facility_ary = get( http_client , same_as: station , to_inspect: true , perse_json: true , generate_instance: true )
    facility_ary.each do | facility |
      puts facility.to_strf
      puts "" * 2
    end
  end

  # @!endgroup

end