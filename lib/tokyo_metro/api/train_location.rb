# 列車ロケーション情報 odpt:Train を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/railway#列車ロケーション情報-odpt:Train
# @note 列車の在線位置を表す。列車ロケーション情報は、駅にいる状態（odpt:fromStation のみ値が存在）、「駅間を走行中」という状態（odpt:fromStation, odpt:toStation の両方に値が存在）を用いた相対位置情報表記に対応する。
# @note 列車ロケーション情報は、始発から終電まで、列車が運行している時間帯に取得可能である。
# @note 始発駅や終着駅には、東京メトロ以外の駅名が出現する場合があるが、他社の駅時刻表や駅情報等は提供しない。
class TokyoMetro::Api::TrainLocation < TokyoMetro::Api::MetaClass::RealTime

  include ::TokyoMetro::Modules::Api::ToFactory::Generate::Group::TrainLocation
  include ::TokyoMetro::ClassNameLibrary::Api::TrainLocation

  # @!group クラスメソッド - データの取得・保存

  # 列車ロケーション情報 odpt:Train を取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param railway_line [String] 鉄道路線【必須】 <odpt:railway - odpt:Railway>
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは「odpt.Train:TokyoMetro.路線名.列車番号」） <owl:sameAs - URL>
  # @param train_number [String] 列車番号 <odpt:trainNumber - xsd:string>
  # @param train_type [String] 列車種別（各停(odpt.TrainType:Local)、急行(odpt.TrainType:Express)、快速(odpt.TrainType:Rapid)、特急(odpt.TrainType:LimitedExpress)など） <odpt:trainType - odpt:TrainType>
  # @param train_owner [String] 車両の所属会社 <odpt:trainOwner - odpt:TrainOwner>
  # @param railway_direction [String] 方面（渋谷方面行きodpt.RailDirection:TokyoMetro.Shibuyaなど） <odpt:railDirection - odpt:RailDirection>
  # @param delay [Integer] 遅延時間（秒） <odpt:delay - xsd:integer>
  # @param starting_station [String] 列車の始発駅 <odpt:startingStation - odpt:Station>
  # @param terminal_station [String] 列車の終着駅 <odpt:terminalStation - odpt:Station>
  # @param from_station [String] 列車が出発した駅 <odpt:fromStation - odpt:Station>
  # @param to_station [String] 列車が向かっている駅 <odpt:toStation - odpt:Station>
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [::Array]
  def self.get( http_client , railway_line ,
    id_urn: nil , same_as: nil ,
    train_number: nil , train_type: nil , train_owner: nil ,
    railway_direction: nil , delay: nil ,
    starting_station: nil , terminal_station: nil , from_station: nil , to_station: nil ,
    perse_json: false , generate_instance: false , to_inspect: false )

    factory_for_getting.process( http_client , railway_line , id_urn , same_as , train_number , train_type , train_owner , railway_direction , delay ,
      starting_station , terminal_station , from_station , to_station ,
      perse_json , generate_instance , to_inspect )
  end

  # 列車ロケーション情報 odpt:Train を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス
  # @param railway_line [String] 鉄道路線【必須】 <odpt:railway - odpt:Railway> - odpt:Train に路線名のクラス (rdf:type - odpt:Train) を指定している。
  # @param file_type [Symbol] 保存するファイルの種類
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは「odpt.Train:TokyoMetro.路線名.列車番号」） <owl:sameAs - URL>
  # @param train_number [Integer] 列車番号 <odpt:trainNumber - xsd:string>
  # @param train_type [String] 列車種別（各停(odpt.TrainType:Local)、急行(odpt.TrainType:Express)、快速(odpt.TrainType:Rapid)、特急(odpt.TrainType:LimitedExpress)など） <odpt:trainType - odpt:TrainType>
  # @param train_owner [String] 車両の所属会社 <odpt:trainOwner - odpt:TrainOwner>
  # @param railway_direction [String] 方面（渋谷方面行きodpt.RailDirection:TokyoMetro.Shibuyaなど） <odpt:railDirection - odpt:RailDirection>
  # @param delay [Integer] 遅延時間（秒） <odpt:delay - xsd:integer>
  # @param starting_station [String] 列車の始発駅 <odpt:startingStation - odpt:Station>
  # @param terminal_station [String] 列車の終着駅 <odpt:terminalStation - odpt:Station>
  # @param from_station [String] 列車が出発した駅 <odpt:fromStation - odpt:Station>
  # @param to_station [String] 列車が向かっている駅 <odpt:toStation - odpt:Station>
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [nil]
  def self.save( http_client , filename , railway_line , file_type: :yaml ,
    id_urn: nil , same_as: nil ,
    train_number: nil , train_type: nil , train_owner: nil ,
    railway_direction: nil , delay: nil ,
    starting_station: nil , terminal_station: nil , from_station: nil , to_station: nil ,
    to_inspect: false )

    data = get( http_client , railway_line ,
      id_urn: id_urn , same_as: same_as ,
      train_number: train_number , train_type: train_type , train_owner: train_owner ,
      railway_direction: railway_direction , delay: delay ,
      starting_station: starting_station , terminal_station: terminal_station , from_station: from_station , to_station: to_station ,
      perse_json: true , generate_instance: generate_instance , to_inspect: to_inspect )

    save_data( data , filename , file_type: file_type )
  end

  # 各路線の列車ロケーション情報を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  def self.save_datas_of_all_railway_lines( http_client , file_type: :yaml , generate_instance: false , to_inspect: true )

    # 路線のリスト
    # @return [::Array]
    railway_line_list = [ "odpt.Railway:TokyoMetro.Ginza" ,
      "odpt.Railway:TokyoMetro.Marunouchi" ,
      # "odpt.Railway:TokyoMetro.MarunouchiBranch" ,
      "odpt.Railway:TokyoMetro.Hibiya" ,
      "odpt.Railway:TokyoMetro.Tozai" ,
      "odpt.Railway:TokyoMetro.Chiyoda" ,
      "odpt.Railway:TokyoMetro.Yurakucho" ,
      "odpt.Railway:TokyoMetro.Hanzomon" ,
      "odpt.Railway:TokyoMetro.Namboku" , 
      "odpt.Railway:TokyoMetro.Fukutoshin" ]

    railway_line_list.each do | railway_line |
      save_datas_of_each_group( http_client , railway_line , file_type: file_type , generate_instance: generate_instance , to_inspect: to_inspect )
      sleep(1)
    end
  end

  # 個別の列車ロケーション情報を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  # @param railway_line [String] 鉄道路線【必須】 <odpt:railway - odpt:Railway> - odpt:Train に路線名のクラス (rdf:type - odpt:Train) を指定している。
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @param file_type [Symbol] 保存するファイルの種類【必須】
  # @return [nil]
  def self.save_datas_of_each_group( http_client , railway_line , file_type: :yaml , generate_instance: false , to_inspect: true )
    factory_for_saving_datas_of_each_group.process( http_client , railway_line , db_dirname , file_type , generate_instance , to_inspect )
  end

  # @!group テスト

  # データ取得のテスト
  # @param http_client [HTTPClient]
  # @param railway_line_name [String] 路線名（"xxxx.yyyy" を指定すると、"odpt.Railway:xxxx.yyyy" の路線情報を呼び出す）
  # @return [nil]
  def self.get_test( http_client , railway_line_name )
    puts "● Train location"
    railway_line_name = "odpt.Railway:#{railway_line_name}"
    train_location = get( http_client , railway_line_name , to_inspect: true , perse_json: true , generate_instance: true )
    puts train_location.to_strf
  end

end