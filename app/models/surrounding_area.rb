class SurroundingArea < ActiveRecord::Base
  has_many :station_facility_platform_info_surrounding_areas
  has_many :station_facility_platform_infos , through: :station_facility_platform_info_surrounding_areas
  has_many :station_facility_infos , through: :station_facility_platform_infos
end
