# 乗り換えの情報の配列
class TokyoMetro::Api::StationFacility::Info::Platform::Transfer::List < Array

  def seed( station_facility_platform_info_id , indent: 0 )
    self.each do | transfer_info |
      transfer_info.seed( station_facility_platform_info_id , indent: indent + 1 )
    end
  end

end