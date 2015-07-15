class BarrierFreeFacility::EscalatorDirection::Pattern < ActiveRecord::Base

  has_many :escalator_direction_infos , class: ::BarrierFreeFacility::EscalatorDirection::Info , foreign_key: :pattern_id
  has_many :service_detail_infos , through: :escalator_direction_infos

  include ::TokyoMetro::Modules::Decision::Common::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction
  include ::TokyoMetro::Modules::Attributes::Common::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction

  private

  def direction_pattern_info
    self
  end

end
