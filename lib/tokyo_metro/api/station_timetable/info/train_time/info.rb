# 個別の列車の情報を扱うクラス
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase

  include ::TokyoMetro::Modules::Api::Info::Decision::TerminalStation
  include ::TokyoMetro::Modules::Api::Info::Decision::TrainType

  include ::TokyoMetro::Modules::Api::Info::SetDataToHash
  include ::TokyoMetro::Modules::Api::Info::ToJson
  include ::TokyoMetro::Modules::Api::Info::SeedCompleted

  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  include ::TokyoMetro::Modules::Api::Common::NotRealTime

  # Constructor
  def initialize( departure_time , terminal_station , train_type ,
    is_last , is_origin , car_composition , notes )
    @departure_time = departure_time
    @terminal_station = terminal_station
    @train_type = train_type
    @is_last = is_last
    @is_origin = is_origin
    @car_composition = car_composition
    @notes = notes

    @seed_completed = false
  end

  def ==( other )
    [ :departure_time , :terminal_station , :train_type , :is_last , :is_origin , :car_composition , :notes ].all?{ | method |
      self.send( method ) == other.send( method )
    }
  end

  # @!group 列車の情報

  # @return [DateTime] 列車の出発時間（ISO8601時刻形式） - odpt:Time
  # @example
  #  05:09
  attr_reader :departure_time
  # @return [String] 行先 - odpt:Station
  attr_reader :terminal_station
  # @return [String] 列車種別 - odpt:TrainType
  # @example
  #  各停 (odpt.TrainType:Local) 、急行 (odpt.TrainType:Express) 、快速 (odpt.TrainType:Rapid) 、特急 (odpt.TrainType:LimitedExpress) など
  attr_reader :train_type
  # @return [Integer] 車両数 - xsd:integer
  # @note 駅に停車する車両数が列車毎に異なる場合に格納される。
  attr_reader :car_composition

  # @!group 補足情報

  # @return [Boolean] 最終電車か否かの真偽値（最終電車の場合 true） - xsd:boolean
  attr_reader :is_last
  # @return [Boolean] 始発駅か否かの真偽値（始発駅の場合 true） - xsd:boolean
  attr_reader :is_origin
  # @return [String] その他の注釈（接続、通過待ちなど） - xsd:string
  attr_reader :notes

  # @!endgroup

  alias :bound_for :terminal_station
  alias :last_train? :is_last
  alias :start_from_this_station? :is_origin
  alias :cars :car_composition

  def start_from_this_station?
    @is_origin or @notes.any? { |i| i.instance_of?( ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::StartFromThisStation ) }
  end

  def platform_number
    info = @notes.find { |i| i.instance_of?( ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::PlatformNumber ) }
    if info.nil?
      nil
    else
      info.number
    end
  end
  alias :depart_from :platform_number

  # @!group 列車の出発時刻

  # 列車の出発時刻を配列として取得するメソッド
  # @return [::Array <Integer>]
  # @note 「hh:mm」の形（hは時間、mは分）の文字列を、時間と分（それぞれ整数）の配列に変換するメソッド
  def departure_time_array
    [ @departure_time.hour , @departure_time.min ]
  end

  # 列車の出発時刻を Time のインスタンスとして取得するメソッド
  # @param time_now [DateTime] 現在の時刻（日付の情報を使用するために必要）
  # @param change_day_of_midnight_train [Boolean] false の場合は日付の変更を行わない。（default は true だが、::TokyoMetro::Api::StationTimetable::Info::TrainTime::List#last_train_not_departed_yet? では false に設定している）
  # @return [DateTime]
  # @note 時刻の比較を簡単にする。
  def departure_datetime( time_now = ::TokyoMetro.time_now , change_day_of_midnight_train: true )
    train_hour , train_min = self.departure_time_array
    time = DateTime.new( time_now.year , time_now.month , time_now.day , train_hour , train_min , 0 , Rational( 9 , 24 ) )

    unless change_day_of_midnight_train
      return time
    end

    # 【注意】change_day_of_midnight_train が true の場合
    # 以下の処理は、この列車が含まれる時刻表が
    # TokyoMetro::Api::StationTimetable#today_s_timetable などによって、
    # time_now （通常は現在時刻）の時点で適用される時刻表として選択されていることを前提にしている。

    # 日付が変わった直後の深夜の列車か否か
    midnight_train = self.class.depart_in_midnight?( train_hour )

    #-------- 【以下、書きかけ】

    # 現在は深夜か

    unless midnight_train
      return time
    end
    # 出発時刻が 0:00 - 2:59 で、現在時刻が3時を過ぎている場合
    if midnight_train and time_now.hour >= 3
      # 列車の発車の日付は「現在の日付【が】変わった後」の0時~2時となるため、日付を1日進める。
      time.next_day

    # 出発時刻が 3:00 - 22:59 で、現在時刻が3時より前の場合

    # 時刻表に掲載されている時間が2時より後（3時~23時）かつ
    # 現在が0時~2時の場合
    elsif train_hour > 2 and time_now.hour <= 2
      time.prev_day

    elsif train_hour <= 2 and time_now.hour <= 2
      time
    else # train_hour > 2 and time_now.hour > 2
      time
    end

  end

  # @!group 列車の出発時刻の判定

  # 指定した時刻より前に出発するか否かの判定
  # @param time [DateTime] 時刻の設定（デフォルトは現在時刻）
  # @return [Boolean]
  def before_now?( time = ::TokyoMetro.time_now )
    self.departure_datetime( time ) > time
  end

  # 指定した時刻より後に出発するか否かの判定
  # @param time [DateTime] 時刻の設定（デフォルトは現在時刻）
  # @return [Boolean]
  def after_now?( time = ::TokyoMetro.time_now )
    self.departure_datetime( time ) <= time
  end

  alias :already_depart? :before_now?
  alias :will_arrive? :after_now?

  # @!group 列車の停車駅の判定

  # ある駅に停車するか否かを判定するメソッド
  # @param stations [String] 判定する駅名
  # @return [Boolean]
  # @note 複数指定した場合は、指定された【すべて】の駅に停車する列車を取得する。
  def stops_at?( *stations )
    if stations == [ nil ]
      true
    elsif @stops.nil?
      true
    else
      stations.all? { | station |
        ( station.string? and @stops.include?( station ) ) # or ( station.instance_of?( Station ) and @stops.include?( station ) )
      }
    end
  end
  alias :stop_at? :stops_at?
  alias :goes_to? :stops_at?
  alias :go_to? :stops_at?

  # @!group 列車の情報の取得

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = ::Hash.new

    set_data_to_hash( h , "odpt:departureTime" , @departure_time.strftime( "%H:%M" ) )
    set_data_to_hash( h , "odpt:destinationStation" , @terminal_station )
    set_data_to_hash( h , "odpt:trainType" , @train_type )
    set_data_to_hash( h , "odpt:isLast" , @is_last )
    set_data_to_hash( h , "odpt:isOrigin" , @is_origin )
    set_data_to_hash( h , "odpt:carComposition" , @car_composition )
    set_data_to_hash( h , "odpt:notes" , @notes )

    h
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    h = self.to_h
    str_ary = ::Array.new
    str_ary << ( "出発：" + h[ "odpt:departureTime" ] )
    str_ary << ( "行先："  + h[ "odpt:destinationStation" ] )
    str_ary << ( "種別："  + h[ "odpt:trainType" ] )

    str_note_ary = ::Array.new
    if h[ "odpt:isLast" ]
      str_note_ary << "【最終】"
    end
    if h[ "odpt:isOrigin" ]
      str_note_ary << "【当駅始発】"
    end
    if h[ "odpt:carComposition" ].integer?
      str_note_ary << "［#{h[ "odpt:carComposition" ]}両編成］"
    end

    str_ary << "　" * 3 + str_note_ary.join(" ")

    if h[ "odpt:note" ].present?
      str_ary << "　" * 3 + h[ "odpt:note" ]
    end

    str_ary.map { | str | " " * indent + str }.join( "\n" )
  end

  alias :to_strf :to_s

# @!group クラスメソッド (2) - データの取得・保存

  def self.factory_for_this_class
    factory_for_generating_train_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_station_train_time
  end

# @!group クラスメソッド (3) - 運行時刻についてのメソッド

  # 深夜（日付変更後）の列車か否かの判定
  # @param h [DateTime] 時刻の設定（「時」を指定する）
  # @return [Boolean]
  def self.depart_in_midnight?(h)
    h < ::TokyoMetro::CHANGE_DATE
  end

  # @!endgroup

end