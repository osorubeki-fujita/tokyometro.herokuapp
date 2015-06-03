class StationFacility::Info < ActiveRecord::Base
  has_many :station_infos , class: ::Station::Info , foreign_key: :station_facility_info_id
  has_many :passenger_surveys , through: :station_infos

  has_many :station_facility_platform_infos , class: ::StationFacilityPlatformInfo , foreign_key: :station_facility_info_id
  has_many :station_facility_platform_info_surrounding_areas , through: :station_facility_platform_infos
  has_many :surrounding_areas , through: :station_facility_platform_infos

  has_many :connecting_railway_line_infos , through: :station_infos
  has_many :railway_lines , through: :connecting_railway_line_infos
  # has_many :railway_lines , through: :station_infos
  has_many :operators , through: :railway_lines

  has_many :station_facility_name_aliases , class: ::StationFacility::NameAlias , foreign_key: :station_facility_info_id
  has_many :barrier_free_facility_infos , class: ::BarrierFreeFacility::Info , foreign_key: :station_facility_info_id
  has_many :point_infos , class: ::Point::Info , foreign_key: :station_facility_info_id

  def platform_infos
    station_facility_platform_infos
  end

end
