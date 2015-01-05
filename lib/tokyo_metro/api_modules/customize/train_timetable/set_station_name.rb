# 列車時刻表の、列車の始発駅・終着駅に関する情報を処理する機能を提供するモジュールを格納する名前空間
# @note API からの情報のカスタマイズ
module TokyoMetro::ApiModules::Customize::TrainTimetable::SetStationName

  # モジュールをクラスにセットするためのモジュール関数
  # @return [nil]
  # @note {::TokyoMetro::Api::TrainTimetable::Info} に対し {::TokyoMetro::ApiModules::Customize::TrainTimetable::SetStationName::Info} を prepend する。
  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::TrainTimetable::SetStationName::Info
    end
  end

end