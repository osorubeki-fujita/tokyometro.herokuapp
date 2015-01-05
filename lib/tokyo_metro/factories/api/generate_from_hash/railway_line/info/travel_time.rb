# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::RailwayLine::Info::TravelTime < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::NotOnTheTopLayer

  def variables
    [ "odpt:fromStation" , "odpt:toStation" , "odpt:necessaryTime" ].map { | str | @hash[ str ] }
  end

  def self.instance_class
    ::TokyoMetro::Api::RailwayLine::Info::TravelTime::Info
  end

end