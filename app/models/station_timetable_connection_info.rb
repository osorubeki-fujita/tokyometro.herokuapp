class StationTimetableConnectionInfo < ActiveRecord::Base
  has_many :train_times
  # has_many :station_train_times
  belongs_to :station
end