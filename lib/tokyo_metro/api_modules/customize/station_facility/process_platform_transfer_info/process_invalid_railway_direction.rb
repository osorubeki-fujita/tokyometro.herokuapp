module TokyoMetro::ApiModules::Customize::StationFacility::ProcessPlatformTransferInfo::ProcessInvalidRailwayDirection

  def self.set_modules
    ::TokyoMetro::Api::StationFacility::Info::Platform::Transfer.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessPlatformTransferInfo::ProcessInvalidRailwayDirection::Info::Platform::Transfer
    end
  end

end