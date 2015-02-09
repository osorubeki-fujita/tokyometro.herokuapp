# 始発駅の情報を扱うクラスを格納する名前空間
module TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::StartingStation

  # 文字列をもとにインスタンスを取得するメソッド
  # @param str [String] 文字列
  # @return [Ayase or Wakoshi]
  def self.set_from_string( str )
    case str
    when "綾瀬"
      Ayase.instance
    when "和光市"
      Wakoshi.instance
    else
      puts str
      raise "Error"
    end
  end

end