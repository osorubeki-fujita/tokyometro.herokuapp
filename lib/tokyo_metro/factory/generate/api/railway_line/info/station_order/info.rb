# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::RailwayLine::Info::StationOrder::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  def variables
    [ "odpt:index" , "odpt:station" ].map { | str | @hash[ str ] }
  end

  def self.instance_class
    ::TokyoMetro::Api::RailwayLine::Info::StationOrder::Info
  end

end