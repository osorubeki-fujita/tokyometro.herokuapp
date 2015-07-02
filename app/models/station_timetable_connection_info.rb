class StationTimetableConnectionInfo < ActiveRecord::Base
  has_many :train_times
  # has_many :station_train_times
  include ::Association::To::Station::Info
end