class BarrierFreeFacility::ServiceDetail::Info < ActiveRecord::Base

  belongs_to :info , class: ::BarrierFreeFacility::Info
  belongs_to :pattern , class: ::BarrierFreeFacility::ServiceDetail::Pattern
  has_one :escalator_direction_info , class: ::BarrierFreeFacility::EscalatorDirection::Info , foreign_key: :service_detail_info_id

  def station_facility_info
    info.station_facility_info
  end

  def has_any_info?
    pattern.has_any_info? or has_escalator_direction_info?
  end

  def has_escalator_direction_info?
    escalator_direction_info.present?
  end

  def service_detail_pattern
    pattern
  end

end
