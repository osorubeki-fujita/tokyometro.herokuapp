class BarrierFreeFacilityPlaceName < ActiveRecord::Base
  has_many :barrier_free_facility_root_infos
  has_many :barrier_free_facilities , through: :barrier_free_facility_root_infos

  def root_infos
    barrier_free_facility_root_infos
  end

  def facilities
    barrier_free_facility_root_infos
  end

end