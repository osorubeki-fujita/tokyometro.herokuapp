class StationTimetable < ActiveRecord::Base
  belongs_to :operation_day
  has_many :station_train_times

  has_many :station_timetable_fundamental_infos

  has_many :stations , through: :station_timetable_fundamental_infos
  has_many :railway_lines , through: :station_timetable_fundamental_infos
  has_many :operators , through: :station_timetable_fundamental_infos
  has_many :railway_directions , through: :station_timetable_fundamental_infos
end