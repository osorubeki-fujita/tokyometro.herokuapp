class RailwayDirection < ActiveRecord::Base
  belongs_to :railway_line
  include ::Association::To::Station::Info

  has_many :station_timetable_fundamental_infos
  has_many :station_timetables , through: :station_timetable_fundamental_infos

  has_many :train_timetables
  has_many :station_facility_platform_info_transfer_infos

  has_many :train_locations
  has_many :train_location_olds
end