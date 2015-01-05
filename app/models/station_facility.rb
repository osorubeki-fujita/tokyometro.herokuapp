class StationFacility < ActiveRecord::Base
  has_many :stations
  # has_many :railway_lines , through: :stations

  has_many :passenger_surveys , through: :stations

  has_many :station_facility_platform_infos
  has_many :surrounding_areas , through: :station_facility_platform_infos

  has_many :connecting_railway_lines , through: :stations
  has_many :railway_lines , through: :connecting_railway_lines
  has_many :operators , through: :railway_lines

  has_many :station_facility_aliases

  has_many :barrier_free_facilities
  has_many :points
end