#「データ検索 API を利用するリアルタイム情報」の配列（メタクラス）
class TokyoMetro::Api::MetaClass::RealTime::List < TokyoMetro::Api::MetaClass::Fundamental::List

  include ::TokyoMetro::Modules::Api::Common::RealTime

  def valid?( time = ::TokyoMetro.time_now )
    self.all? { | info | info.valid?( time ) }
  end

  def update!( *args , time: ::TokyoMetro.time_now )
    unless valid?( time )
      self.delete!( &:present? )
      new_infos = self.class.toplevel_namespace.get( *args , perse_json: true , generate_instance: true )
      new_infos.each do | info |
        self.push( info )
      end
    end
    return self
  end

end