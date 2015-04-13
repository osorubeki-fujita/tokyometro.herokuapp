# 個別の駅・路線・方面の時刻表を扱うクラス
class TokyoMetro::Api::StationTimetable::Info < TokyoMetro::Api::MetaClass::NotRealTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase
  include ::TokyoMetro::Modules::Common::Info::Decision::SameAs
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info
  include ::TokyoMetro::Modules::Api::Info::Decision::RailwayLine
  include ::TokyoMetro::Modules::Api::Info::Decision::CurrentStation

  # Constructor
  def initialize( id_urn , same_as , dc_date , station_timetable_fundamental_infos ,
    weekdays , saturdays , holidays )

    @id_urn = id_urn
    @same_as = same_as
    @dc_date = dc_date

    @fundamental_infos = station_timetable_fundamental_infos

    @weekdays = weekdays
    @saturdays = saturdays
    @holidays = holidays

    puts @same_as
  end

  # @!group 時刻表のメタデータ (For developers)

  # 固有識別子 - URL
  # @return [String]
  # @note 命名ルールは「odpt.StationTimetable:TokyoMetro.路線名.駅名.方面名」
  attr_reader :same_as

  # データ生成時刻（ISO8601日付時刻形式） - xsd:dateTime
  # @return [DateTime]
  # @example
  #  2013–01–13T15:10:00+09:00
  attr_reader :dc_date

  # @!group 時刻表のメタデータ (For users)

  # 駅 - odpt:Station
  # @return [String]
  # attr_reader :station

  # 路線 - odpt:Railway
  # @return [String]
  # attr_reader :railway_line

  # 運行会社 - odpt:Operator
  # @return [String]
  # attr_reader :operator

  # 方面 - odpt:RailDirection
  # @return [String]
  # attr_reader :railway_direction

  attr_reader :fundamental_infos

  # @!group 時刻表データ（配列）

  # 平日ダイヤ
  # @return [Info::Train::List <Info::Train::Info (odpt:StationTimetableObject)>]
  # @note 拡張性を考慮し、#weekdays の別名として #friday を定義する。（例：JR埼京線）
  attr_reader :weekdays

  # 土曜ダイヤ
  # @return [Info::Train::List <Info::Train::Info (odpt:StationTimetableObject)>]
  attr_reader :saturdays

  # 休日ダイヤ
  # @return [Info::Train::List <Info::Train::Info (odpt:StationTimetableObject)>]
  # @note 拡張性を考慮し、#holidays の別名として #sundays を定義する。（例：都営バス 品98）
  attr_reader :holidays

  # 金曜ダイヤ
  # @return [Info::Train::List <Info::Train::Info (odpt:StationTimetableObject)>]
  alias :fridays :weekdays

  # 日曜ダイヤ
  # @return [Info::Train::List <Info::Train::Info (odpt:StationTimetableObject)>]
  alias :sundays :holidays

  [ :weekdays , :saturdays , :holidays , :fridays , :sundays ].each do | method_name |
    eval <<-DEF
      alias :#{ method_name.to_s.singularize } :#{ method_name }
    DEF
  end

  def timetables
    [ @weekdays , @saturdays , @holidays ]
  end

  def terminal_stations( *days )
    if days.present?
      t = days.map { | day_type | self.send( day_type ) }
    else
      t = timetables
    end
    t.map( &:terminal_stations ).flatten.sort.uniq
  end

  def combination_of_timetable_types_and_operation_days
    [
      [ @weekdays , ::OperationDay.find_by_name_en( ::TokyoMetro::Static.operation_days.weekday.en ) ] ,
      [ @holidays , ::OperationDay.find_by_name_en( ::TokyoMetro::Static.operation_days.saturday_and_holiday.en ) ]
    ]
  end

  # @!group 時刻表の情報の取得 (1)

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new

    set_data_to_hash( h , "\@id" , @id_urn )
    set_data_to_hash( h , "owl:sameAs" , @same_as )
    set_data_to_hash( h , "dc:date" , @dc_date )

    set_data_to_hash( h , "odpt:operator" , @operator )
    set_data_to_hash( h , "odpt:railway" , @railway_line )
    set_data_to_hash( h , "odpt:station" , @station )
    set_data_to_hash( h , "odpt:railDirection" , @railway_direction )

    set_data_to_hash( h , "odpt:weekdays" , @weekdays )
    set_data_to_hash( h , "odpt:saturdays" , @saturdays )
    set_data_to_hash( h , "odpt:holidays" , @holidays )

    h
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  # @note #to_strf の alias として定義する。
  def to_s
    self.to_strf
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @return [String]
  def to_strf
    h = self.to_h
    hash_keys_ary_1 = [ "\@id" , "owl:sameAs" , "dc:date" ]
    hash_keys_ary_2 = [ "odpt:operator" , "odpt:railway" , "odpt:station" , "odpt:railDirection" ]
    hash_keys_ary_3 = [ "odpt:weekdays" , "odpt:saturdays" , "odpt:holidays" ]

    str_ary = ::Array.new
    str_ary << "● #{@station}"
    str_ary << ""

    [ hash_keys_ary_1 , hash_keys_ary_2 ].each do | hash_keys_ary |
      hash_keys_ary.each do | key |
        if h[ key ].present?
          str_ary << ( " " * 2 + key.ljust(32) + h[ key ].to_s )
        end
      end
      str_ary << ""
    end

    str_ary << " " * 2 + "○ Timetable"
    hash_keys_ary_3.each do | key |
      str_ary << ( " " * 4 + key )
      str_ary << h[ key ].to_strf(6)
    end

    str_ary.join( "\n" )
  end

  # @!group 時刻表の情報の取得 (2)

  # 平日・土曜・休日それぞれの時刻表データを値とするハッシュを返すメソッド
  # @param variables [::Array <Symbol>] ハッシュに格納するデータ (:weekdays , :saturdays , :holidays) を指定する。【可変長引数】
  # @note variables に何も指定しなかった場合は【すべて】のデータを格納する。
  # @return [Hash]
  def timetable_hash( *variables , first: false , last: false )
    h = ::TokyoMetro::Api::StationTimetable::Info::Hash.new
    weekdays , satudays , holidays = timetable_hash_set_settings( variables )
    timetable_hash_set_data_to_hash( h , "odpt:weekdays" , @weekdays , weekdays , first , last )
    timetable_hash_set_data_to_hash( h , "odpt:saturdays" , @saturdays , saturdays , first , last )
    timetable_hash_set_data_to_hash( h , "odpt:holidays" , @holidays , holidays , first , last )
    h
  end

  # @!group 指定された条件に合った時刻表を返すメソッド

  # 指定された日付の時刻表を返すメソッド
  # @param d [DateTime] 時刻の設定（デフォルトは現在時刻）
  # @param to_hash [Boolean] 返す値を Info::Hash のインスタンスにするか否かの設定
  # @return [Info::List] to_hash を false (default) にした場合
  # @return [Info::Hash] to_hash を true にした場合
  def today_s_timetable( d = ::TokyoMetro.time_now , to_hash: false )
    raise "Error" unless d.instance_of?( ::DateTime )
    timetable_v = today_s_timetable_varible(d)
    timetable = self.send( timetable_v )
    unless to_hash
      timetable
    else
      self.timetable_hash( timetable_v )
    end
  end

  # 指定された時刻より前に発車する列車を取得するメソッド
  # @param date [DateTime] 時刻の設定（デフォルトは現在時刻）
  # @param variables [::Array] 時刻を取得する曜日の設定【可変長引数】
  # @return [List <Train>] variables に何も指定しなかった場合 - 【メソッドを実行した日】についてのデータを配列で返す。
  # @return [Hash] variables にオプション (:weekdays , :saturdays , :holidays) を指定した場合 - 【指定された曜日】についてのデータをハッシュで返す。
  def before_now( *variables , date: ::TokyoMetro.time_now )
    get_specific_datas_as_for_date( :before_now , variables , date )
  end

  # 指定された時刻より後に発車する列車を取得するメソッド
  # @param date [DateTime] 時刻の設定（デフォルトは現在時刻）
  # @param variables [::Array] 時刻を取得する曜日の設定【可変長引数】
  # @return [List <Train>] variables に何も指定しなかった場合 - 【メソッドを実行した日】についてのデータを配列で返す。
  # @return [Hash] variables にオプション (:weekdays , :saturdays , :holidays) を指定した場合 - 【指定された曜日】についてのデータをハッシュで返す。
  def after_now( *variables , date: ::TokyoMetro.time_now )
    get_specific_datas_as_for_date( :after_now , variables , date )
  end

  # 特定の行先の列車を取得するメソッド
  # @param stations [::Array <Station>] 行先
  # @return [List <Train>]
  # @note 行先を複数指定した場合は、指定された【いずれか】の駅を行先とする列車を取得する。
  def bound_for( *variables , stations: nil , date: ::TokyoMetro.time_now )
    get_specific_datas_as_for_stations( :bound_for , variables , stations , date )
  end

  # 特定の駅に停車する列車を取得するメソッド
  # @param stations [::Array <Station>] 停車駅
  # @return [List <Train>]
  # @note 停車駅を複数指定した場合は、指定された【すべて】の駅に停車する列車を取得する。
  def stop_at( *variables , stations: nil , date: ::TokyoMetro.time_now )
    get_specific_datas_as_for_stations( :stop_at , variables , stations , date )
  end

  alias :go_to :bound_for

  # @!group クラスメソッド (3) - 時刻表の種類

  # 許容される時刻表の種類（Info クラスのインスタンス変数）
  # @return [::Array <Symbol>]
  # @note 取りうる値は、原則として :weekdays（平日）, :satudays（土曜）, :holidays（休日）である。
  # @note 特殊なダイヤや他の鉄道・バスへの拡張性を考慮し、:fridays, :sundays（日曜…休日ダイヤと日曜ダイヤが異なる場合を考慮）, :no_school_days（学休日）, :new_year（年末年始）, :all_night（終夜運転）, :extra_operation（臨時ダイヤ）, :business_use（業務用） , :maintainance（線路保守・システム保守・テスト用）, :emergency（災害時・緊急時用）も認める設定とする。
  def self.type_of_timetables
    [
      :weekdays , :satudays , :holidays ,
      :fridays , :sundays ,
      :no_school_days , :new_year , :all_night , :extra_operation , :business_use , :maintainance , :emergency
    ]
  end

  # @!group その他

  # CSS ファイル内で使用する路線の色を取得するメソッド
  # @return [String]
  def color_in_css_class
    ::TokyoMetro::Search::Line.color_in_css_class( @railway_line )
  end

  def instance_in_db
    ::StationTimetable.find_by_same_as( @same_as )
  end

  [ :stations , :railway_lines , :operators , :railway_directions ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        @fundamental_infos.#{ method_name }
      end
    DEF
  end

  # @param train_timetables [::TokyoMetro::Api::TrainTimetable::List <::TokyoMetro::Api::TrainTimetable::Info>]
  def seed_train_times( train_timetables )
    station_timetable_info = ::TokyoMetro::Factory::Seed::Api::StationTrainTime::TrainInStationTimetable::StationTimetableInfo.new( self )

    # 各曜日の時刻の処理〈ここから〉
    combination_of_timetable_types_and_operation_days.each do | station_timetable_in_a_day , operation_day_in_db |
      station_timetable_in_a_day.seed( station_timetable_info , operation_day_in_db , train_timetables )
    end
    # 各曜日の時刻の処理〈ここまで〉
    return nil
  end

  private

  # #timetable_hash でハッシュに格納するダイヤの設定を行うメソッド
  def timetable_hash_set_settings( variables )
    if variables.empty?
      [ true , true , true ]
    else
      timetable_hash_set_settings_check_validity_of_variables( variables )
      [ variables.include?( :weekdays ) , variables.include?( :saturdays ) , variables.include?( :holidays ) ]
    end
  end

  # #timetable_hash の設定において不正なエラーがないかチェックするメソッド
  # @param variables [::Array <Symbol>] timetable_hash の設定
  # @note 与えられた配列の中に、Info.type_of_timetables （配列）に含まれていないものがないことを確認する。
  def timetable_hash_set_settings_check_validity_of_variables( variables )
    if variables.any? { | element | !( self.class.type_of_timetables.include?( element ) ) }
      puts "Variables: #{variables.to_s}"
      puts "Type of timetables: #{self.class.type_of_timetables.to_s}"
      raise "Error"
    end
  end

  def timetable_hash_set_data_to_hash( h , key , value , setting , first , last )
    if setting
      if first
        if last
          h[ key ] = ::Array.new( [ value.first , value.last ] )
        else
          h[ key ] = ::Array.new( [ value.first ] )
        end
      else
        if last
          h[ key ] = ::Array.new( [ value.last ] )
        else
          h[ key ] = value
        end
      end
    end
  end

  def today_s_timetable_varible(d)
    # puts "● today_s_timetable_varible"
    # puts "#{d.to_s} (Class: #{d.class.name})"
    raise "Error" unless d.instance_of?( ::DateTime )

    now_midnight = ( d.hour < ::TokyoMetro::CHANGE_DATE )

    # 現在時刻は月曜の 0:00 - 2:59 で、日曜ダイヤに日付変更後の列車が存在し、日曜ダイヤの最終列車がまだ出発していない場合
    if now_midnight and d.monday? and self.sundays.last_train_depart_after_the_day_change? and self.sundays.last_train_not_departed_yet?(d)
      :holidays
    # 現在時刻は土曜の 0:00 - 2:59 で、金曜ダイヤに日付変更後の列車が存在し、金曜ダイヤの最終列車がまだ出発していない場合
    elsif now_midnight and d.saturday? and self.fridays.last_train_depart_after_the_day_change? and self.fridays.last_train_not_departed_yet?(d)
      :fridays
    # 現在時刻は日曜の 0:00 - 2:59 で、土曜ダイヤに日付変更後の列車が存在し、土曜ダイヤの最終列車がまだ出発していない場合
    elsif now_midnight and d.sunday? and @saturdays.last_train_depart_after_the_day_change? and @saturdays.last_train_not_departed_yet?(d)
      :saturdays
    # 現在時刻は 0:00 - 2:59 で、前日が休日で、休日ダイヤに日付変更後の列車が存在し、休日ダイヤの最終列車がまだ出発していない場合
    elsif now_midnight and d.prev_day.holiday? and @holiday.last_train_depart_after_the_day_change? and @holiday.last_train_not_departed_yet?(d)
      :holidays
    # 現在時刻は 0:00 - 2:59 で、すでに前日のダイヤの列車の運行が終了している場合（→ 現在の日付の朝からのダイヤを表示する）
    # 現在時刻が 3:00 - 23:59 の場合
    else
      case d.wday
      when 5
        :fridays
      when 6
        :saturdays
      when 0
        :holidays
      else
        :weekdays
      end
    end
  end

  # before_now , after_now で共通して使用するメソッド
  def get_specific_datas_as_for_date( method_name , variables , date )
    if variables.empty?
      self.today_s_timetable( date ).send( method_name , date )
    else
      h = ::TokyoMetro::Api::StationTimetable::Info::Hash.new
      weekdays , satudays , holidays = timetable_hash_set_settings( variables )
      timetable_hash_set_data_to_hash( h , "odpt:weekdays" , @weekdays.send( method_name , date ) , weekdays )
      timetable_hash_set_data_to_hash( h , "odpt:saturdays" , @saturdays.send( method_name , date ) , saturdays )
      timetable_hash_set_data_to_hash( h , "odpt:saturdays" , @holidays.send( method_name , date ) , holidays )
      h
    end
  end

  # bound_for , stop_at で共通して使用するメソッド
  def get_specific_datas_as_for_stations( method_name , variables , stations , date )
    # puts "● get_specific_datas_as_for_stations"
    # puts variables.to_s
    # puts stations.to_s
    # puts "#{date.to_s} (Class: #{date.class.name})"
    if variables.empty?
      self.today_s_timetable( date ).send( method_name , stations )
    else
      h = ::TokyoMetro::Api::StationTimetable::Info::Hash.new
      weekdays , satudays , holidays = timetable_hash_set_settings( variables )
      timetable_hash_set_data_to_hash( h , "odpt:weekdays" , @weekdays.send( method_name , stations ) , weekdays )
      timetable_hash_set_data_to_hash( h , "odpt:saturdays" , @saturdays.send( method_name , stations ) , saturdays )
      timetable_hash_set_data_to_hash( h , "odpt:saturdays" , @holidays.send( method_name , stations ) , holidays )
      h
    end
  end

  def station_same_as__is_in?( *variables )
    super( *variables , compared: self.stations )
  end

  def on_the_railway_line_of?( *variables )
    super( *variables , compared: self.railway_lines )
  end

  alias :is_on_the_railway_line_of? :on_the_railway_line_of?

end