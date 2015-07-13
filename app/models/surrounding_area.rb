class SurroundingArea < ActiveRecord::Base
  has_many :platform_surrounding_areas ,class: ::StationFacility::Platform::SurroundingArea , foreign_key: :surrounding_area_id
  has_many :station_facility_platform_infos , through: :platform_surrounding_area
  has_many :station_facility_infos , through: :station_facility_platform_infos
end
