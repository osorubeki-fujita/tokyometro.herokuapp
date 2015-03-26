class BarrierFreeFacilityToiletAssistant < ActiveRecord::Base
  belongs_to :barrier_free_facility_info
  belongs_to :barrier_free_facility_toilet_assistant_pattern

  scope :station_facility , ->{
    barrier_free_facility_info.station_facility
  }

  def pattern
    barrier_free_facility_toilet_assistant_pattern
  end

end