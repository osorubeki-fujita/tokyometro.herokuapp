class StationFacility::Info < ActiveRecord::Base
  has_many :station_infos , class: ::Station::Info , foreign_key: :station_facility_info_id
  has_many :passenger_surveys , through: :station_infos

  has_many :platform_infos , class: ::StationFacility::Platform::Info , foreign_key: :station_facility_info_id
  has_many :platform_surrounding_areas_info , through: :platform_infos
  has_many :surrounding_areas , through: :platform_surrounding_areas_info

  has_many :connecting_railway_line_infos , through: :station_infos
  has_many :railway_lines , through: :connecting_railway_line_infos
  # has_many :railway_lines , through: :station_infos
  has_many :operators , through: :railway_lines

  has_many :station_facility_name_aliases , class: ::StationFacility::NameAlias , foreign_key: :station_facility_info_id
  has_many :barrier_free_facility_infos , class: ::BarrierFreeFacility::Info , foreign_key: :station_facility_info_id
  has_many :point_infos , class: ::Point::Info , foreign_key: :station_facility_info_id

end
