# ハンドル型電動車いす利用可能経路の情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::LinkForMobilityScooter::Info < TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::MetaClass::LinkForMobilityScooterAndStairlift::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::LinkForMobilityScooter

  def self.factory_for_this_class
    factory_for_generating_barrier_free_link_for_mobility_scooter_info_from_hash
  end

end