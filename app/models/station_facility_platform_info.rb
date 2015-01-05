class StationFacilityPlatformInfo < ActiveRecord::Base
  has_many :station_facility_platform_info_transfer_infos
  has_many :station_facility_platform_info_barrier_free_facilities
  has_many :station_facility_platform_info_surrounding_areas
  has_many :barrier_free_facilities , through: :station_facility_platform_info_barrier_free_facilities
  has_many :surrounding_areas , through: :station_facility_platform_info_surrounding_areas
  belongs_to :station_facility
  belongs_to :railway_line
  belongs_to :railway_direction
end