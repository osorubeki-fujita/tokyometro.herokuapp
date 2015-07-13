class BarrierFreeFacility::EscalatorDirection::Pattern < ActiveRecord::Base

  has_many :escalator_direction_infos , class: ::BarrierFreeFacility::EscalatorDirection::Info , foreign_key: :pattern_id
  has_many :service_detail_infos , through: :escalator_direction_infos

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction

end
