class StationTimetableStartingStationInfo < ActiveRecord::Base
  # has_many :train_times
  has_many :station_train_times
  belongs_to :station

  def to_s
    "#{ station.name_ja }始発"
  end

end