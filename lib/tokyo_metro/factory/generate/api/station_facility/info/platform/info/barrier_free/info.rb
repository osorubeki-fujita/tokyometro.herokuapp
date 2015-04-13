# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::StationFacility::Info::Platform::Info::BarrierFree::Info < TokyoMetro::Factory::Generate::Api::StationFacility::Info::Platform::Info::BarrierFreeAndSurroundingArea::Info

  def self.instance_class
    platform_barrier_free_info_class
  end

end