# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::RailwayLine::Info::StationOrder < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::NotOnTheTopLayer

  def variables
    [ "odpt:index" , "odpt:station" ].map { | str | @hash[ str ] }
  end

  def self.instance_class
    ::TokyoMetro::Api::RailwayLine::Info::StationOrder::Info
  end

end