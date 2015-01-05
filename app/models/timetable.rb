class Timetable < ActiveRecord::Base
  belongs_to :operator
  belongs_to :railway_line
  belongs_to :station
  belongs_to :railway_direction
  belongs_to :operation_day
  has_many :station_train_times
end