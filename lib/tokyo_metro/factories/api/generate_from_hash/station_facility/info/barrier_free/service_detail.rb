# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::ServiceDetail < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::MetaClass

  def variables
    [ "ugsrv:serviceStartTime" , "ugsrv:serviceEndTime" , "odpt:operationDays" ].map { | str | @hash[ str ] }
  end

  def self.instance_class
    service_detail_class
  end

end