# 個別の列車の情報の配列
class TokyoMetro::Api::StationTimetable::Info::Train::List < TokyoMetro::Api::MetaClass::Fundamental::List

  # @note {TokyoMetro::Api::TrainTimetable::Info::StationTime::List#seed} と同じロジック
  def seed( id_in_db , operation_day_id , railway_line_instance , station_instance )
    self.each do | train |
      train.seed( id_in_db , operation_day_id , railway_line_instance , station_instance )
    end
  end

  # @!group 時刻表の情報の取得

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 1 )
  end

  # @!group 列車の出発時刻に関するメソッド

  # 指定された時刻より前に出発する列車を取得するメソッド
  # @param d [DateTime] 時刻の設定（デフォルトは現在時刻）
  # @return [List <Info>]
  def before_now( d = ::TokyoMetro.time_now )
    self.class.new( self.select { | train | train.before_now?(d) } )
  end

  # 指定された時刻より後に出発する列車を取得するメソッド
  # @param d [DateTime] 時刻の設定（デフォルトは現在時刻）
  # @return [List <Info>]
  def after_now( d = ::TokyoMetro.time_now )
    self.class.new( self.select { | train | train.after_now?(d) } )
  end

  # @!group 列車の行先に関するメソッド

  # 特定の行先の列車を取得するメソッド
  # @param stations [::Array <Station>] 行先
  # @return [::Array <Train>]
  # @note 行先を複数指定した場合は、指定された【いずれか】の駅を行先とする列車を取得する。
  def bound_for( *stations )
    self.class.new( self.select { | train | train.bound_for?( *stations ) } )
  end
  alias :go_to :bound_for

  # @!group 列車の停車駅に関するメソッド

  # 特定の駅に停車する列車を取得するメソッド
  # @param stations [::Array <Station>] 停車する駅
  # @return [List <Train>]
  # @note 停車駅を複数指定した場合は、指定された【すべて】の駅に停車する列車を取得する。
  def stop_at( *stations )
    self.class.new( self.select { | train | train.stops_at?( *stations ) } )
  end

  # 指定された時刻より後に出発し、特定の駅に停車する／特定の駅を行先とする最初の n 本の列車を取得するメソッド
  # @return [List <Train>]
  def first_train_after_now( d = Time.now , number: 1 , bound_for: nil , stop_at: nil )
    i = 0
    ary = ::Array.new
    self.each do | train |
      if train.departure_time >= d and train.bound_for?( *bound_for ) and train.stops_at?( *stop_at )
        if number == 1
          return train
        else
          ary << train
          i += 1
        end
      end
      if i = number
        break
      end
    end
    self.new( ary )
  end

  alias :already_depart :before_now
  alias :will_arrive :after_now
  alias :go_to :stop_at

  # 日付が変わった後に終電があるか否かの判定
  # @return [Boolean]
  # @note 配列の最後の列車が 0:00 - 2:59 の間に出発するか否かによって判定を行う。
  def last_train_depart_after_the_day_change?
    self.last.departure_datetime.hour < ::TokyoMetro::CHANGE_DATE
  end

  # 終電の出発前か否かの判定
  # @param d [DateTime] 時刻の設定（デフォルトは現在時刻）
  # @return [Boolean]
  # @note 配列の最後の列車が出発前か否かによって判定を行う。
  def last_train_not_departed_yet?( d = ::TokyoMetro.time_now )
    d <= self.last.departure_datetime( today: false )
  end

end