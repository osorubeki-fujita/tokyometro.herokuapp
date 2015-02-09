# 「日吉・目黒方面からの三田線方面行き列車が白金高輪で南北線の列車に接続する」という情報を扱うクラス
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::ShirokaneTakanawa::ToeiMitaLineConnectedToNambokuLine < ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::ConnectionInfo

  include ::Singleton

  # Constructor
  def initialize
    super( "白金高輪" , true )
  end
  attr_reader :station , :connection

  # 自身の情報を文字列に変換して返すメソッド
  # @param tadashigaki [Boolean] 但し書きを追加するか否かの設定（true の場合は但し書きを設定。default は false）
  # @return [String]
  def to_s( tadashigaki = false )
    str = "白金高輪で東京メトロ南北線の列車に接続します。"
    if tadashigaki
      str += "（ただし、列車の遅延等により接続できない場合もありますのでご了承ください）"
    end
    str
  end

  # CSS のクラスの名称
  # @return [String]
  def css_class
    "note_connection_to_train_for_namboku_line_at_shirokanetakanawa"
  end

end