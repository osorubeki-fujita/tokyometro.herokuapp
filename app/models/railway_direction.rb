class RailwayDirection < ActiveRecord::Base
  belongs_to :railway_line
  belongs_to :station

  has_many :timetables
  has_many :train_timetables
  has_many :station_facility_platform_info_transfer_infos

  has_many :train_locations
  has_many :train_location_olds
end