class BarrierFreeFacilityRootInfo < ActiveRecord::Base
  belongs_to :barrier_free_facility_info
  belongs_to :barrier_free_facility_place_name
end