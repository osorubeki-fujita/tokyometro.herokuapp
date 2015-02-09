# 各列車のロケーション情報を格納する配列
class TokyoMetro::Api::TrainLocation::List < TokyoMetro::Api::MetaClass::RealTime::List

  include ::TokyoMetro::ClassNameLibrary::Api::TrainLocation

  def update!( http_client , railway_line , time: ::TokyoMetro.time_now )
    super( http_client , railway_line , time: time )
  end

end