class TimetableConnectionInfo < ActiveRecord::Base
  has_many :train_times
  belongs_to :station
end