# 各列車のロケーション情報を格納する配列
class TokyoMetro::Api::TrainLocation::List < TokyoMetro::Api::MetaClass::RealTime::List

  def valid?( time = ::TokyoMetro.time_now )
    self.all? { | info | info.valid > time }
  end

=begin
  def update( http_client , line , time = ::TokyoMetro.time_now )
    unless self.valid?( time )
      ary = ::TokyoMetro::Api::TrainLocation.get( http_client , line , perse_json: true , generate_instance: true )
    else
      self
    end
  end
=end

end