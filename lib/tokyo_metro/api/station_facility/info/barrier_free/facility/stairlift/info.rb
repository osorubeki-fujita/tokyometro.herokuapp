# 階段昇降機の情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Stairlift::Info < TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::MetaClass::LinkForMobilityScooterAndStairlift::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Stairlift

  def self.factory_for_this_class
    factory_for_generating_barrier_free_stairlift_info_from_hash
  end

end