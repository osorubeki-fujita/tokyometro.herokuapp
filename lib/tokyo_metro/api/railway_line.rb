# 路線情報 odpt:Railway を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/railway#鉄道路線情報-odpt:Railway
# @note 路線情報 odpt:Railwayは、鉄道路線の情報を示す。 運行系統名、駅間所要時間、駅間順序などを加筆・修正したものとなる。
class TokyoMetro::Api::RailwayLine < TokyoMetro::Api::MetaClass::Hybrid

  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine

  # @!group クラスメソッド - データの取得・保存

  # 路線情報を取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは「odpt.Railway:TokyoMetro.路線名」） <owl:sameAs - URL>
  # @param title [String] 運行系統名 <dc:title - xsd:string>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param railway_line_code [String] 路線コード <odpt:lineCode - xsd:string>
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [::Array]
  # @note 固有識別子 id は、支線には別IDを割り当てる。
  def self.get( http_client ,
    id_urn: nil , same_as: nil , title: nil , operator: nil , railway_line_code: nil ,
    perse_json: false , generate_instance: false , to_inspect: false )

    factory_for_getting.process( http_client , id_urn , same_as , title , operator , railway_line_code ,
      perse_json , generate_instance , to_inspect )
  end

  # 路線情報を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは「odpt.Railway:TokyoMetro.路線名」） <owl:sameAs - URL>
  # @param title [String] 運行系統名 <dc:title - xsd:string>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param railway_line_code [String] 路線コード <odpt:lineCode - xsd:string>
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [nil]
  def self.save( http_client , filename , file_type: :yaml ,
    id_urn: nil , same_as: nil , title: nil , operator: nil , railway_line_code: nil ,
    to_inspect: true )

    data = get( http_client ,
      id_urn: id_urn , same_as: same_as , title: title , operator: operator , railway_line_code: railway_line_code ,
      perse_json: true , generate_instance: false , to_inspect: to_inspect )

    # data = eval( data.to_s.gsub( /(?:\r\n|\r)/ ,"\n" ).encode( "UTF-8" ) )

    save_data( data , filename , file_type: file_type )
  end

  # @!group テスト・開発

  # データ取得のテスト
  # @param http_client [HTTPClient]
  # @param railway_line [String] 路線（"xxxx.yyyy" を指定すると、"odpt.Railway:xxxx.yyyy" の駅情報を呼び出す）
  # @return [nil]
  def self.get_test( http_client , railway_line )
    unless /\Aodpt\.Railway\:/ === railway_line
      railway_line = "odpt.Railway:#{railway_line}"
    end
    puts "● #{get_test_title}"
    ary = get( http_client , same_as: railway_line , to_inspect: true , perse_json: true , generate_instance: true )
    puts "#{railway_line} (#{ary.length})"
    puts ary.sort_by_railway_line_order.to_strf
  end

  def self.get_test_for_each_line( http_client )
    ::TokyoMetro::Static.railway_lines_operated_by_tokyo_metro.each do | line |
      self.get_test( http_client , line )
      sleep( 2 )
    end
  end

  def self.get_station_order_for_each_line( http_client )
    ary = get( http_client , to_inspect: true , perse_json: true , generate_instance: true ).sort_by_railway_line_order

    dirname_str = "#{db_dirname}/for_development"
    ::FileUtils.mkdir_p( dirname_str )
    Dir.chdir( dirname_str )

    ary.each do | railway_line |
      file = File.open( "TokyoMetro_#{railway_line.railway_line_code_for_filename}.txt" , "w:utf-8" )
      railway_line.station_order.each do | station_info |
        station_facility = station_info.name.gsub( "odpt\.Station\:" , "odpt\.StationFacility\:" ).gsub( /\.[a-zA-Z]+\.([a-zA-Z]+)\Z/ ) { | matched | "\.#{$1}" }

        file.print station_info.name
        file.print "\t"
        file.print station_facility
        file.print "\n"
      end
      file.close
    end
  end

  # データ取得のテスト
  # @return [nil]
  def self.get_geo_test( http_client , geo_long , geo_lat , radius )
    puts "● #{get_test_title} (geo)"
    result = get_geo( http_client , geo_long , geo_lat , radius , to_inspect: true , perse_json: true , generate_instance: true )
    puts "(#{result.length})"
    result.sort_by( &:operator ).each do | rail |
      puts rail.to_strf
      puts "" * 2
    end
  end

  # @!endgroup

  class << self

    alias :generate_all_info_of_railway_from_json :generate_from_saved_json
    alias :save_datas_of_railway_line :save_datas_of_each_group

    private

    def get_test_title
      "Railway Line"
    end

  end

end