# 列車の補足情報の配列
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::List < Array

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s
    self.map( &:to_s ).join( "／" )
  end

  # 列車の補足情報を配列として取得するメソッド
  # @param str [String] 列車の補足情報の文字列
  # @return [::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::List <classes under TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note> or nil]
  def self.generate_from_string( str )
    if str.string?
      ary = str.split( /\,/ )
      ary = ary.map { | info | self.upper_namespace.generate_from_string( info ) }
      self.new( ary )
    else
      self.new
    end
  end

end