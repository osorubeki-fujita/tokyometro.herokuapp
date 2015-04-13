# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::TrainTimetable::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id_urn = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]
    dc_date = @hash[ "dc:date" ]
    train_number = @hash[ "odpt:trainNumber" ]
    railway_line = @hash[ "odpt:railway" ]
    train = @hash[ "odpt:train" ]
    operator = @hash[ "odpt:operator" ]
    train_type = @hash[ "odpt:trainType" ]
    railway_direction = @hash[ "odpt:railDirection" ]

    starting_station = @hash[ "odpt:startingStation" ]
    terminal_station = @hash[ "odpt:terminalStation" ]
    train_owner = @hash[ "odpt:trainOwner" ]

    weekdays = generate_timetable_data_from_hash( "odpt:weekdays" )
    saturdays = generate_timetable_data_from_hash( "odpt:saturdays" )
    holidays = generate_timetable_data_from_hash( "odpt:holidays" )

    [ id_urn , same_as , dc_date , train_number , railway_line , train , operator , train_type , railway_direction ,
      starting_station , terminal_station , train_owner ,
      weekdays , saturdays , holidays ]
  end

  private

  def generate_timetable_data_from_hash( key )
    unless @hash[ key ].nil?
      #puts key
      #puts @hash.keys.to_s
      #puts @hash[ "owl:sameAs" ]
      self.class.station_time_list_class.new( @hash[ key ].map { | train |
        self.class.station_time_class.generate_from_hash( train )
      })
    else
      nil
    end
  end

end

__END__

odpt:TrainTimetableObject::プロパティ
値域
説明
必須

odpt:departureTime
odpt:Time
出発時間 (ISO8601時刻形式, e.g. 05:33)。特急ロマンスカーの小田急線から東京メトロ路線内に到着する列車にはこのキーが存在しない。

odpt:departureStation
odpt:Station
出発駅のID。IDにはodpt:Stationのowl:sameAsの値を利用する。特急ロマンスカーの小田急線から東京メトロ路線内に到着する列車にはこのキーが存在しない。

odpt:arrivalTime
odpt:Time	到着時間 (ISO8601時刻形式, e.g. 05:33)。
特急ロマンスカーの小田急線から東京メトロ路線内に到着する列車について、および東京メトロ線内の終着駅についてこのキーが存在する。

odpt:arrivalStation	odpt:Station
到着駅のID。IDにはodpt:Stationのowl:sameAsの値を利用する。特急ロマンスカーの小田急線から東京メトロ路線内に到着する列車について、およびおよび東京メトロ線内の終着駅についてこのキーが存在する。