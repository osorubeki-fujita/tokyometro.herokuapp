# 各路線の列車運行情報を格納する配列
class TokyoMetro::Api::TrainInformation::List < TokyoMetro::Api::MetaClass::RealTime::List

  include ::TokyoMetro::ClassNameLibrary::Api::TrainInformation

  # 各路線の情報を路線の建設順に並べ替えるメソッド
  # @return [List]
  def sort_by_railway_line_order
    self.class.new( self.sort_by { | line_info | ::TokyoMetro::Static.railway_lines[ line_info.railway_line ].order } )
  end

  def update!( http_client , time: ::TokyoMetro.time_now )
    super( http_client , time: time )
  end

end