class BarrierFreeFacility::EscalatorDirection::Info < ActiveRecord::Base

  belongs_to :service_detail_info , class: ::BarrierFreeFacility::ServiceDetail::Info
  belongs_to :pattern , class: ::BarrierFreeFacility::EscalatorDirection::Pattern

  include ::TokyoMetro::Modules::Decision::Common::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction
  include ::TokyoMetro::Modules::Attributes::Common::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction

  private

  def direction_pattern_info
    pattern
  end

end
