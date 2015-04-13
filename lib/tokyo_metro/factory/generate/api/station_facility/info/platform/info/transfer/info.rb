# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::StationFacility::Info::Platform::Info::Transfer::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  def variables
    [ "odpt:railway" , "odpt:railDirection" , "odpt:necessaryTime" ].map { | str | @hash[ str ] }
  end

  def self.instance_class
    platform_transfer_info_class
  end

end