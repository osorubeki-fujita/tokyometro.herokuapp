class StationTrainTime < ActiveRecord::Base
  belongs_to :timetable
  belongs_to :train_timetable
end