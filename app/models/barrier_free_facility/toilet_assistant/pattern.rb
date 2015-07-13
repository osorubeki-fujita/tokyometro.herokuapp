class BarrierFreeFacility::ToiletAssistant::Pattern < ActiveRecord::Base
  has_many :toilet_assistant_infos , class: ::BarrierFreeFacility::ToiletAssistant::Info , foreign_key: :pattern_id
  has_many :infos , through: :toilet_assistant_infos

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::WheelChair::Accessibility::AliasTowardsAvailability
  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::WheelChair::MethodMissing
  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::ToiletAssistant

end
