class Point < ActiveRecord::Base
  belongs_to :station_facility
  belongs_to :point_category

  has_many :station_points
  has_many :stations , through: :station_points

  # geocoded_by :code
  # after_validation :geocode

  scope :stations , -> {
    station_facility.stations
  }

  scope :elevator , -> {
    where( elevator: true )
  }
  scope :closed , -> {
    where( closed: true )
  }
end