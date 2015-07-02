class BarrierFreeFacilityServiceDetail < ActiveRecord::Base

  belongs_to :barrier_free_facility_info , class: ::BarrierFreeFacility::Info , foreign_key: :barrier_free_facility_info_id
  belongs_to :barrier_free_facility_service_detail_pattern
  has_one :barrier_free_facility_escalator_direction
  
  def pattern
    barrier_free_facility_service_detail_pattern
  end

  def station_facility_info
    barrier_free_facility_info.station_facility_info
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
