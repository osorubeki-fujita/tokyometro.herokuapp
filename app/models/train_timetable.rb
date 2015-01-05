class TrainTimetable < ActiveRecord::Base
  belongs_to :railway_line
  belongs_to :operator
  belongs_to :railway_direction
  belongs_to :train_owner
  belongs_to :operation_day
  belongs_to :starting_station , class: Station
  belongs_to :terminal_station , class: Station
  has_many :station_train_times
end