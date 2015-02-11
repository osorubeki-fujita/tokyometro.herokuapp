class BarrierFreeFacilityEscalatorDirectionPattern < ActiveRecord::Base

  has_many :barrier_free_facility_escalator_direction

  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction

end