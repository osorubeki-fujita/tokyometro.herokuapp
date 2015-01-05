# 個別の駅の発着時刻情報の配列
class TokyoMetro::Api::TrainTimetable::Info::StationTime::List < TokyoMetro::Api::MetaClass::Fundamental::List

  # @note {::TokyoMetro::Api::StationTimetable::Info::Train::List#seed} と同じロジック
  def seed( id_in_db , operation_day_id )
    self.each do | station_time |
      station_time.seed( id_in_db , operation_day_id )
    end
  end

  def stopping_stations
    self.map { | item | item.station }
  end

end