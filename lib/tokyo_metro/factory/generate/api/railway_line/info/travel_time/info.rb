# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::RailwayLine::Info::TravelTime::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  def variables
    [ "odpt:fromStation" , "odpt:toStation" , "odpt:necessaryTime" ].map { | str | @hash[ str ] }
  end

  def self.instance_class
    ::TokyoMetro::Api::RailwayLine::Info::TravelTime::Info
  end

end