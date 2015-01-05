module TokyoMetro::ApiModules::Customize::StationFacility::ProcessPlatformTransferInfo::ConvertRailwayLineName

  def self.set_modules
    ::TokyoMetro::Api::StationFacility::Info::Platform::Transfer.class_eval do
      prepend ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessPlatformTransferInfo::ConvertRailwayLineName::Info::Platform::Transfer
    end
  end

end