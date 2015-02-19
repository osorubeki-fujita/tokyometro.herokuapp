# 駅時刻表の、列車の始発駅に関する情報を処理する機能を提供するモジュール
# @note API からの情報の修正
# @note {::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info} に対する機能
module TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::Origin::Info::TrainTime::Info

  # Constructor
  # @return [::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info]
  def initialize( departure_time , terminal_station , train_type ,
is_last , is_origin , car_composition , notes )
    super
    process_info_of_starting_station
  end

  private

  # 補足情報に始発駅情報が含まれているにも関わらず「当駅始発」となっている場合に、「当駅始発」の情報を削除する。
  # @return [nil]
  def process_info_of_starting_station
    if @notes.any? { | info | info.instance_of?( ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::StartingStation::Ayase ) or info.instance_of?( ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::StartingStation::Wakoshi ) } and @is_origin
      @is_origin = false
    end
    return nil
  end

end