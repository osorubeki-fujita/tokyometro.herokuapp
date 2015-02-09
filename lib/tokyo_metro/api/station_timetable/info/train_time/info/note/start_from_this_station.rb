# 「当駅始発」の情報を扱うクラス
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::StartFromThisStation

  include ::Singleton

  # Constructor
  def initialize
  end

  # 自身の情報を文字列に変換して返すメソッド
  # @return [String]
  def to_s
    "当駅始発"
  end

end