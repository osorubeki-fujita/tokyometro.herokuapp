class BarrierFreeFacilityServiceDetail < ActiveRecord::Base
  belongs_to :barrier_free_facility
  belongs_to :barrier_free_facility_service_detail_pattern
  has_one :barrier_free_facility_escalator_direction

  scope :station_facility , ->{
    barrier_free_facility.station_facility
  }
end