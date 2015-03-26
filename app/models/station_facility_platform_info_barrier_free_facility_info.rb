class StationFacilityPlatformInfoBarrierFreeFacilityInfo < ActiveRecord::Base
  belongs_to :station_facility_platform_info
  belongs_to :barrier_free_facility_info , class: BarrierFreeFacility::Info , foreign_key: :barrier_free_facility_info_id
end