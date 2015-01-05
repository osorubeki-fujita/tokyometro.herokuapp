class StationFacilityPlatformInfoTransferInfo < ActiveRecord::Base
  belongs_to :station_facility_platform_info
  belongs_to :railway_line
  belongs_to :railway_direction
end