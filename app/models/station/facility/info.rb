class Station::Facility::Info < ActiveRecord::Base

  has_many :station_infos , class: ::Station::Info , foreign_key: :station_facility_info_id
  has_many :passenger_surveys , through: :station_infos , class: ::PassengerSurvey

  has_many :platform_infos , class: ::Station::Facility::Platform::Info , foreign_key: :station_facility_info_id
  has_many :platform_surrounding_areas_info , through: :platform_infos , class: ::Station::Facility::Platform::SurroundingArea
  has_many :surrounding_areas , through: :platform_surrounding_areas_info , class: ::SurroundingArea

  has_many :connecting_railway_line_infos , through: :station_infos , class: ::ConnectingRailwayLine::Info
  has_many :railway_line_infos , through: :connecting_railway_line_infos , class: ::Railway::Line
  # has_many :railway_line_infos , through: :station_infos <- In this case, railway lines of another operators will not be selected.

  has_many :operators , through: :railway_line_infos

  has_many :station_facility_name_aliases , class: ::Station::Facility::NameAlias , foreign_key: :station_facility_info_id
  has_many :barrier_free_facility_infos , class: ::BarrierFreeFacility::Info , foreign_key: :station_facility_info_id
  has_many :point_infos , class: ::Point::Info , foreign_key: :station_facility_info_id

end
