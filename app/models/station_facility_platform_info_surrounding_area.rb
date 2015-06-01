class StationFacilityPlatformInfoSurroundingArea < ActiveRecord::Base
  belongs_to :station_facility_platform_info
  belongs_to :surrounding_area
end
