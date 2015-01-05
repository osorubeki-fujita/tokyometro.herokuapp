# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::Platform::Transfer < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::NotOnTheTopLayer

  def variables
    [ "odpt:railway" , "odpt:railDirection" , "odpt:necessaryTime" ].map { | str | @hash[ str ] }
  end

  def self.instance_class
    ::TokyoMetro::Api::StationFacility::Info::Platform::Transfer
  end

end