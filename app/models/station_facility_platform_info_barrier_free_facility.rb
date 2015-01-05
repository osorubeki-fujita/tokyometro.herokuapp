class StationFacilityPlatformInfoBarrierFreeFacility < ActiveRecord::Base
  belongs_to :station_facility_platform_info
  belongs_to :barrier_free_facility
end