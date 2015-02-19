# バリアフリー施設情報に関する不正確な情報を修正する機能を提供するモジュールを格納する名前空間
# @note prepend {TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::BarrierFree::Info} in {TokyoMetro::Api::StationFacility::Info::BarrierFree::Info}
# @note prepend {TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::Platform::Info} in {TokyoMetro::Api::StationFacility::Info::Platform::Info}
module TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea

  def self.set_modules
    ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::BarrierFree::Info
    end

    ::TokyoMetro::Api::StationFacility::Info::Platform::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::Platform::Info
    end
  end

end