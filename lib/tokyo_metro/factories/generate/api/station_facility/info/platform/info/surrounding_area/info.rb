# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Generate::Api::StationFacility::Info::Platform::Info::SurroundingArea::Info < TokyoMetro::Factories::Generate::Api::StationFacility::Info::Platform::Info::BarrierFreeAndSurroundingArea::Info

  def self.instance_class
    platform_surrounding_area_info_class
  end

end