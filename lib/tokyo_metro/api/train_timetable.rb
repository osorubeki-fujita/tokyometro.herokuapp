# 列車時刻表 odpt:TrainTimetable を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/railway#列車時刻表-odpt:TrainTimetable
class TokyoMetro::Api::TrainTimetable < TokyoMetro::Api::MetaClass::NotRealTime

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  # @!group クラスメソッド - データの取得・保存

  # 列車時刻表 odpt:TrainTimetable を取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは「odpt.TrainTimetable:TokyoMetro.路線名.列車番号.曜日」） <owl:sameAs - URL>
  # @param train_number [String] 列車番号 <odpt:trainNumber - xsd:string>
  # @param railway_line [String] 路線 <odpt:railway - odpt:Railway>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param train_type [String] 列車種別 <odpt:trainType - odpt:TrainType>
  # @param railway_direction [String] 方面 <odpt:railDirection - odpt:RailDirection>
  # @param starting_station [String] 列車の始発駅（他社線始発の場合のみ指定可能）<odpt:startingStation - odpt:Station>
  # @param terminal_station [String] 列車の終着駅<odpt:terminalStation - odpt:Station>
  # @param train_owner [String] 車両の所属会社<odpt:trainOwner - odpt:TrainOwner>
  # @param train [String] 列車のID（odpt:Trainのowl:sameAsの値）<odpt:train - odpt:Train>
  # @param perse_json [Boolean] JSONを配列とするか否かの設定（false の場合は文字列とする）
  # @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [::Array]
  def self.get( http_client ,
    id_urn: nil , same_as: nil , train_number: nil , railway_line: nil ,
    operator: nil , train_type: nil , railway_direction: nil ,
    starting_station: nil , terminal_station: nil , train_owner: nil , train: nil ,
    perse_json: false , generate_instance: false , to_inspect: false )

    factory_for_getting.process( http_client , id_urn , same_as , train_number , railway_line ,
      operator , train_type , railway_direction ,
      starting_station , terminal_station , train_owner , train ,
      perse_json , generate_instance , to_inspect )
  end

  # 列車時刻表 odpt:TrainTimetable を取得し保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @param filename [String (filename)] 保存するファイルの名称【必須】
  # @param file_type [Symbol] 保存するファイルの種類【必須】
  # @param id_urn [String] 固有識別子 (ucode) <id - URN>
  # @param same_as [String] 固有識別子（命名ルールは「odpt.TrainTimetable:TokyoMetro.路線名.列車番号.曜日」） <owl:sameAs - URL>
  # @param train_number [String] 列車番号 <odpt:trainNumber - xsd:string>
  # @param railway_line [String] 路線 <odpt:railway - odpt:Railway>
  # @param operator [String] 運行会社 <odpt:operator - odpt:Operator>
  # @param train_type [String] 列車種別 <odpt:trainType - odpt:TrainType>
  # @param railway_direction [String] 方面 <odpt:railDirection - odpt:RailDirection>
  # @param starting_station [String] 列車の始発駅（他社線始発の場合のみ指定可能）<odpt:startingStation - odpt:Station>
  # @param terminal_station [String] 列車の終着駅<odpt:terminalStation - odpt:Station>
  # @param train_owner [String] 車両の所属会社<odpt:trainOwner - odpt:TrainOwner>
  # @param train [String] 列車のID（odpt:Trainのowl:sameAsの値）<odpt:train - odpt:Train>
  # @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定
  # @return [nil]
  def self.save( http_client , filename , file_type: :yaml ,
    id_urn: nil , same_as: nil , train_number: nil , railway_line: nil ,
    operator: nil , train_type: nil , railway_direction: nil ,
    starting_station: nil , terminal_station: nil , train_owner: nil , train: nil ,
    to_inspect: false )

    data = get( http_client ,
      id_urn: id_urn , same_as: same_as , train_number: train_number , railway_line: railway_line ,
      operator: operator , train_type: train_type , railway_direction: railway_direction ,
      starting_station: starting_station , terminal_station: terminal_station , train_owner: train_owner , train: train ,
      perse_json: true , generate_instance: false , to_inspect: to_inspect )

    save_data( data , filename , file_type: file_type )
  end

end