# 「接続なし」の情報を扱うクラス
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::ShirokaneTakanawa::NoConnection < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::ConnectionInfo

  include ::Singleton

  # Constructor
  def initialize
    super( "白金高輪" , false )
  end

  # 自身の情報を文字列に変換して返すメソッド
  # @return [String]
  def to_s
    "白金高輪での目黒方面行きの列車への接続はありません。"
  end

  # CSS のクラスの名称
  # @return [String]
  def css_class
    "note_no_connection_at_shirokanetakanawa"
  end

end