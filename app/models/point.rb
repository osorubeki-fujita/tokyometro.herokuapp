class Point < ActiveRecord::Base
  belongs_to :station_facility
  belongs_to :point_category

  has_many :station_points
  has_many :station_infos , through: :station_points

  # geocoded_by :code
  # after_validation :geocode

  scope :station_infos , -> {
    station_facility.station_infos
  }

  scope :elevator , -> {
    where( elevator: true )
  }
  scope :closed , -> {
    where( closed: true )
  }
end