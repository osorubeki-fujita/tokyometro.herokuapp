# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::ServiceDetail::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::MetaClass

  def variables
    [ "ugsrv:serviceStartTime" , "ugsrv:serviceEndTime" , "odpt:operationDays" ].map { | str | @hash[ str ] }
  end

  def self.instance_class
    barrier_free_service_detail_info_class
  end

end