# 個別の列車時刻表のクラス {TokyoMetro::Api::TrainTimetable::Info} に組み込むモジュール
module TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine::Info

  # 「本来は副都心線の時刻表であるが、有楽町線の時刻表に含まれてしまっている列車か否か」を判定するメソッド
  # @return [Boolean]
  # @note 運行日が休日であることに注意
  def invalid_fukutoshin_line_trains_on_yurakucho_line?
    yurakucho_line? and operated_on_weekdays? and ::TokyoMetro::Modules::Api::Convert::Patches::TrainTimetable::YurakuchoLine.invalid_trains.include?( @train_number )
  end

  def valid_fukutoshin_line_train_info_as_for_invalid_train_in_yurakucho_line( train_number_of_invalid_train )
    fukutoshin_line? and operated_on_weekdays? and @train_number == train_number_of_invalid_train
  end

  # 列車時刻表の配列から、自身に対応する副都心線の列車を取得するメソッド
  # @param ary [::TokyoMetro::Api::TrainTimetable::List]
  # @return [::TokyoMetro::Api::TrainTimetable::Info]
  # @note {::TokyoMetro::Api::TrainTimetable::List#.select_valid_fukutoshin_line_train_info_as_for_invalid_train_in_yurakucho_line} を使用する。
  def valid_fukutoshin_line_train( ary )
    ary.select_valid_fukutoshin_line_train_info_as_for_invalid_train_in_yurakucho_line( @train_number )
  end

  def set_valid_station_times_of_weekdays( valid_station_times )
    @weekdays = valid_station_times
  end

end