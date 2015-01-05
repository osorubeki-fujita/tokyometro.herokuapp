# 個別の列車の情報の配列を値とするハッシュ
class TokyoMetro::Api::StationTimetable::Info::Hash < Hash

  # ハッシュの情報を文字列として取得するメソッド
  # @return [String]
  def to_s
    str_ary = ::Array.new
    self.each do | day , timetable |
      str_ary << day
      str_ary << ""
      timetable.each do | train |
        str_ary << ( " " * 2 + train.to_s )
      end
      str_ary << ""
    end
    str_ary.join( "\n" )
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    str_ary = ::Array.new
    self.each do | key , value |
      str_ary_for_each_timetable = ::Array.new
      str_ary_for_each_timetable << key
      str_ary_for_each_timetable << ""
      str_ary_for_each_timetable << value.to_strf(2)
      str_ary << " " * indent + str_ary_for_each_timetable.join( "\n" )
    end

    str_ary.map { | str | " " * indent }.join( "\n" * 3 )
  end

end