class BarrierFreeFacilityToiletAssistantPattern < ActiveRecord::Base
  has_many :barrier_free_facility_toilet_assistants
  has_many :barrier_free_facilities , through: :barrier_free_facility_toilet_assistants
end