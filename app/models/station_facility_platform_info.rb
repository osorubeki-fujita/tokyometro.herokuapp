class StationFacilityPlatformInfo < ActiveRecord::Base
  has_many :station_facility_platform_info_transfer_infos

  has_many :station_facility_platform_info_barrier_free_facility_infos
  has_many :barrier_free_facility_infos , through: :station_facility_platform_info_barrier_free_facility_infos , class: ::BarrierFreeFacility::Info

  has_many :station_facility_platform_info_surrounding_areas
  has_many :surrounding_areas , through: :station_facility_platform_info_surrounding_areas

  belongs_to :station_facility_info , class: ::StationFacility::Info
  belongs_to :railway_line
  belongs_to :railway_direction

  def transfer_infos
    station_facility_platform_info_transfer_infos
  end

end
