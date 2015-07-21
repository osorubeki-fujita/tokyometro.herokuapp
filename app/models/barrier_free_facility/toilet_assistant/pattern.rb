class BarrierFreeFacility::ToiletAssistant::Pattern < ActiveRecord::Base
  has_many :toilet_assistant_infos , class: ::BarrierFreeFacility::ToiletAssistant::Info , foreign_key: :pattern_id
  has_many :infos , through: :toilet_assistant_infos

  include ::TokyoMetro::Modules::Decision::Common::StationFacility::BarrierFree::WheelChair::Accessibility::AliasTowardsAvailability
  include ::OdptCommon::Modules::MethodMissing::Decision::Common::StationFacility::BarrierFree::WheelChair
  include ::OdptCommon::Modules::Alias::Common::StationFacility::BarrierFree::WheelChair

  include ::TokyoMetro::Modules::Decision::Common::StationFacility::BarrierFree::ToiletAssistant
  include ::OdptCommon::Modules::Attributes::Common::StationFacility::BarrierFree::ToiletAssistant
  include ::OdptCommon::Modules::MethodMissing::Decision::Common::StationFacility::BarrierFree::ToiletAssistant

end
