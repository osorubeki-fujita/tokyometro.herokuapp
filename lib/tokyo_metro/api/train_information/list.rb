# 各路線の列車運行情報を格納する配列
class TokyoMetro::Api::TrainInformation::List < TokyoMetro::Api::MetaClass::RealTime::List

  # 各路線の情報を路線の建設順に並べ替えるメソッド
  # @return [List]
  def sort_by_railway_line_order
    self.class.new( self.sort_by { | line_info | ::TokyoMetro::StaticDatas.railway_lines[ line_info.railway_line ].order } )
  end

end