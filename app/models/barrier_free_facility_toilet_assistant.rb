class BarrierFreeFacilityToiletAssistant < ActiveRecord::Base
  belongs_to :barrier_free_facility
  belongs_to :barrier_free_facility_toilet_assistant_pattern

  scope :station_facility , ->{
    barrier_free_facility.station_facility
  }
end