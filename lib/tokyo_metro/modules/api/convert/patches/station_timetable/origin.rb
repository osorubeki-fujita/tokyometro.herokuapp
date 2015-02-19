# 駅時刻表の、列車の始発駅に関する情報を処理する機能を提供するモジュールを格納する名前空間
# @note API からの情報の修正
module TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::Origin

  # モジュールをクラスにセットするためのモジュール関数
  # @return [nil]
  # @note {::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info} に対し {::TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::Origin::Info::TrainTime::Info} を prepend する。
  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::Origin::Info::TrainTime::Info
    end
  end

end