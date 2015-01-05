class BarrierFreeFacilityPlaceName < ActiveRecord::Base
  has_many :barrier_free_facility_root_infos
  has_many :barrier_free_facilities , through: :barrier_free_facility_root_infos
end