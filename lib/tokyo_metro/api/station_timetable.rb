# 駅時刻表 odpt:StationTimetable を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/railway#駅時刻表-odpt:StationTimetable
# @note 各駅の平日、土曜、休日の列車着時刻、発車時刻と種別の情報を格納する。
class TokyoMetro::Api::StationTimetable < TokyoMetro::Api::MetaClass::NotRealTime

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable

  # @!group クラスメソッド - データの取得・保存

  # 駅時刻表 odpt:StationTimetable を取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは「odpt.StationTimetable:TokyoMetro.路線名.駅名.方面名」） <owl:sameAs - URL>
  # @param station [String] 駅 <odpt:station - odpt:Station>
  # @param railway_line [String] 路線 <odpt:railway - odpt:Railway>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param railway_direction [String] 方面 <odpt:railDirection - odpt:RailDirection>
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [::Array]
  def self.get( http_client ,
    id_urn: nil , same_as: nil , station: nil , railway_line: nil , operator: nil , railway_direction: nil ,
    perse_json: false , generate_instance: false , to_inspect: false )

    factory_for_getting.process( http_client , id_urn , same_as , station , railway_line , operator , railway_direction ,
      perse_json , generate_instance , to_inspect )
  end

  # 駅時刻表 odpt:StationTimetable を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  # @param filename [String (filename)] 保存するファイルの名称【必須】
  # @param file_type [Symbol] 保存するファイルの種類【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは、odpt.StationTimetable:TokyoMetro.路線名.駅名.方面名） <owl:sameAs - URL>
  # @param station [String] 駅 <odpt:station - odpt:Station>
  # @param railway_line [String] 路線 <odpt:railway - odpt:Railway>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param railway_direction [String] 方面 <odpt:railDirection - odpt:RailDirection>
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [nil]
  def self.save( http_client , filename , file_type: :yaml ,
    id_urn: nil , same_as: nil , station: nil , railway_line: nil , operator: nil , railway_direction: nil ,
    to_inspect: false )

    data = get( http_client ,
      id_urn: id_urn , same_as: same_as , station: station , railway_line: railway_line , operator: operator , railway_direction: railway_direction ,
      perse_json: true , generate_instance: false , to_inspect: to_inspect )

    save_data( data , filename , file_type: file_type )
  end

  # @!group テスト

  # データ取得のテスト
  # @return [nil]
  def self.get_test( time_table_of_all_stations , station_name , regexp )
    puts "● #{station_name} Station"
    puts ""

    time_table_of_all_stations = generate_from_saved_json

    unless time_table_of_all_stations.empty?
      ary = time_table_of_all_stations.select{ | timetable |
        ( timetable.instance_of?( Hash ) and regexp === timetable[ "odpt:station" ] ) or ( timetable.instance_of?( self.info_class ) and regexp === timetable.station )
      }
      puts "Length: #{ary.length}"

      if ary.length > 0
        timetable_first = ary.first
        puts timetable_first.to_s

        h = timetable_first.today_s_timetable( to_hash: true )
        puts h.to_s
        # tojo = timetable_first.bound_for( stations: [ "odpt.Station:Tobu.Tojo.Kawagoeshi", "odpt.Station:Tobu.Tojo.ShinrinKoen" ] )
        # puts tojo.to_strf

        # shiki = timetable_first.bound_for( stations: "odpt.Station:Tobu.Tojo.Shiki" )
        # puts shiki.to_strf

        # after_now = timetable_first.after_now
        # puts after_now.to_strf

        # puts timetable_first.timetable_hash( first: true , last: true ).to_strf
      end
    end

  end

  # 補足情報についてのテスト
  # @return [nil]
  def self.inspect_notes( timetables = self.generate_from_saved_json )
    ary = ::Array.new
    # puts timetables.class.name
    timetables.each do | timetable_for_a_direction |
      # puts timetable_for_a_direction.class.name
      timetable_for_a_direction.timetable_hash.values.each do | timetable_for_a_day |
        # puts timetable_for_a_day.class.name
        timetable_for_a_day.each do | train |
          # puts train.class.name
          note = train.note
          if note.present?
            ary << note
            # ary << note.to_s
            # ary << inspect_notes_str( note , timetable_for_a_direction.same_as )
          end
        end
      end
    end
    puts ary.flatten.uniq
  end

  # @!endgroup

  class << self

    alias :generate_all_timetables_from_json :generate_from_saved_json
    alias :save_timetables_of_each_station :save_datas_of_each_group

    private

    def inspect_notes_str( note , timetable_for_a_direction_same_as )
      origin_ary = [ "和光市始発" ,
        "当駅始発,浅草１番線着" ,
        "浅草１番線着" ,
        "１番線発" ,
        "綾瀬駅始発" ]
      shirokanetakanawa_ary = [ "白金高輪駅で東京メトロ南北線に接続します。（ただし、列車の遅延等により接続できない場合もありますのでご了承ください）" ,
        "白金高輪駅で目黒方面行列車に接続しません。" ]

      shirokanetakanawa_str = "当駅始発,白金高輪駅で目黒方面行列車に接続しません。"
      kotakemukaihara_str = "小竹向原駅で和光市行きに連絡します。（ただし、列車の遅れにより連絡しない場合もあります。）"

      yf_ary = [ "東急線内各駅運転" , "東急線内急行運転" , "東急線内特急運転" , "東急線内通勤特急運転" ,
        "東武線内各駅運転" ,
        "西武線内各駅運転" , "西武線内快速急行運転" , "西武線内快速運転" , "西武線内準急運転" ]
      yf_wakoshi_ary = [ "東急線内急行運転,和光市始発" , "東急線内特急運転,和光市始発" , "東急線内通勤特急運転,和光市始発" , "東急線内各駅運転,和光市始発" ]
      tokyu_error_ary = [ "東急線内各駅運転和光市始発," , "東急線内急行運転和光市始発," ]

      if origin_ary.include?( note )
        num = 1
      elsif shirokanetakanawa_ary.include?( note )
        num = 2
      elsif shirokanetakanawa_str == notes
        num = 3
      elsif kotakemukaihara_str == notes
        num = 4
      elsif yf_ary.include?( note )
        num = 5
      elsif yf_wakoshi_ary.include?( note )
        num = 6
      elsif tokyu_error_ary.include?( note )
        num = 7
      else
        num = 8
      end
      "(#{num}) #{timetable_for_a_direction_same_as.ljust(80)} #{note}"
    end

  end

end