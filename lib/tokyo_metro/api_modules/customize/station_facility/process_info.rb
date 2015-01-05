# 駅施設情報に関する不正確な情報を修正する機能を提供するモジュールを格納する名前空間
# @note prepend {TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Info::BarrierFree::Info} in {TokyoMetro::Api::StationFacility::Info::BarrierFree::Info}
# @note prepend {TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Info::Platform::Info} in {TokyoMetro::Api::StationFacility::Info::Platform::Info}
# @note prepend {TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Factory::Info::BarrierFree::Facility::Escalator::Fundamental} in {TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Escalator}
module TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo

  def self.set_modules
    ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Info::BarrierFree::Info
    end

    ::TokyoMetro::Api::StationFacility::Info::Platform::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Info::Platform::Info
    end

    ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Escalator.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Factory::Info::BarrierFree::Facility::Escalator::Fundamental
    end
  end

end