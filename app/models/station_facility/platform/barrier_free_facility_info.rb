class StationFacility::Platform::BarrierFreeFacilityInfo < ActiveRecord::Base
  belongs_to :platform_info , class: ::StationFacility::Platform::Info
  belongs_to :barrier_free_facility_info , class: ::BarrierFreeFacility::Info
end
