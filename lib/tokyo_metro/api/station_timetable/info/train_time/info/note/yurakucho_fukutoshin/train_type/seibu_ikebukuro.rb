# 西武池袋線の乗り入れに関する情報を扱うクラスを格納するモジュール
module TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::SeibuIkebukuro

  # 与えられた文字列（種別）をもとにインスタンスを作成するメソッド
  # @param str [String] 種別を示す文字列
  # @return [subclasses of Fundamental]
  def self.set_from_string( str )
    case str
    when "各駅"
      Local.instance
    when "快速"
      Rapid.instance
    when "準急"
      SemiExpress.instance
    when "快速急行"
      RapidExpress.instance
    else
      puts str
      raise "Error"
    end
  end

end