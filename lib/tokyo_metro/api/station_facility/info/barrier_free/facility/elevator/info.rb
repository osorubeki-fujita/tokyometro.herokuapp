# エレベータの情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Elevator::Info < TokyoMetro::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Elevator

  def self.factory_for_this_class
    factory_for_generating_barrier_free_elevator_info_from_hash
  end

end