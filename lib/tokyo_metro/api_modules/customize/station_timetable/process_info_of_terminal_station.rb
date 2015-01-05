# 駅時刻表の、列車の終着駅に関する情報を処理する機能を提供するモジュールを格納する名前空間
# @note API からの情報のカスタマイズ
module TokyoMetro::ApiModules::Customize::StationTimetable::ProcessInfoOfTerminalStation

  # モジュールをクラスにセットするためのモジュール関数
  # @return [nil]
  # @note {::TokyoMetro::Api::StationTimetable::Info::Train::Info} に対し {::TokyoMetro::ApiModules::Customize::StationTimetable::ProcessInfoOfTerminalStation::Info::Train::Info} を prepend する。
  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info::Train::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::StationTimetable::ProcessInfoOfTerminalStation::Info::Train::Info
    end
  end

end