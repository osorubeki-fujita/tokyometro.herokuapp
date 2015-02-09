# 和光市方面への接続に関する情報を扱うクラス
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::KotakeMukaihara::ConnectedForWakoshi < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::ConnectionInfo

  include ::Singleton

  # Constructor
  def initialize
    super( "小竹向原" , true )
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @param tadashigaki [Boolean] 但し書きを追加するか否かの設定
  # @return [String]
  def to_s( tadashigaki = false )
    str = "小竹向原で和光市行きに接続します。"
    if tadashigaki
      str += "（ただし、列車の遅延等により接続できない場合もありますのでご了承ください）"
    end
    str
  end

end