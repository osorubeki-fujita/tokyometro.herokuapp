class RailwayDirection < ActiveRecord::Base
  belongs_to :railway_line
  include ::Association::To::Station::Info

  has_many :station_timetable_fundamental_infos
  has_many :station_timetable_infos , through: :station_timetable_fundamental_infos

  has_many :train_timetables
  has_many :station_facility_platform_transfer_infos , class: ::StationFacility::Platform::TransferInfo

  has_many :train_location_infos , class: ::Train::Location::Info , foreign_key: :railway_direction_id
end
