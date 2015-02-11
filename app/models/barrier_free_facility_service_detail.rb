class BarrierFreeFacilityServiceDetail < ActiveRecord::Base
  belongs_to :barrier_free_facility
  belongs_to :barrier_free_facility_service_detail_pattern
  has_one :barrier_free_facility_escalator_direction

  def station_facility
    barrier_free_facility.station_facility
  end

  def escalator_direction
    barrier_free_facility_escalator_direction
  end

  def has_any_info?
    barrier_free_facility_service_detail_pattern.has_any_info? or has_escalator_direction_info?
  end

  def has_escalator_direction_info?
    escalator_direction.present?
  end

end