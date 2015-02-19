class BarrierFreeFacilityEscalatorDirectionPattern < ActiveRecord::Base

  has_many :barrier_free_facility_escalator_direction

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction

end