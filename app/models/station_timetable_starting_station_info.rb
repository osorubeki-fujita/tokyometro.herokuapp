class StationTimetableStartingStationInfo < ActiveRecord::Base
  # has_many :train_times
  has_many :station_train_times
  belongs_to :station

  def to_s
    self.station.name_ja + "発"
  end
end