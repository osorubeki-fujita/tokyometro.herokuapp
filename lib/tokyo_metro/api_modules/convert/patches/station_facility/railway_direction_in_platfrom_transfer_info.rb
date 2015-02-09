module TokyoMetro::ApiModules::Convert::Patches::StationFacility::RailwayDirectionInPlatformTransferInfo

  def self.set_modules
    ::TokyoMetro::Api::StationFacility::Info::Platform::Info::Transfer::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Patches::StationFacility::RailwayDirectionInPlatformTransferInfo::Info::Platform::Info::Transfer::Info
    end
  end

end