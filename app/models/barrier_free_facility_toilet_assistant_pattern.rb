class BarrierFreeFacilityToiletAssistantPattern < ActiveRecord::Base
  has_many :barrier_free_facility_toilet_assistants
  has_many :barrier_free_facilities , through: :barrier_free_facility_toilet_assistants

  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::WheelChair::Accessibility::AliasTowardsAvailability
  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::WheelChair::MethodMissing
  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::ToiletAssistant

end