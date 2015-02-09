# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Generate::Api::RailwayLine::Info::TravelTime::Info < TokyoMetro::Factories::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  def variables
    [ "odpt:fromStation" , "odpt:toStation" , "odpt:necessaryTime" ].map { | str | @hash[ str ] }
  end

  def self.instance_class
    ::TokyoMetro::Api::RailwayLine::Info::TravelTime::Info
  end

end