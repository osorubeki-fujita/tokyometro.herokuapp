class StationTimetable < ActiveRecord::Base
  belongs_to :operation_day
  has_many :station_train_times

  has_many :station_timetable_fundamental_infos

  has_many :station_infos , through: :station_timetable_fundamental_infos , class: ::Station::Info
  has_many :railway_lines , through: :station_timetable_fundamental_infos
  has_many :operators , through: :station_timetable_fundamental_infos
  has_many :railway_directions , through: :station_timetable_fundamental_infos

  def fundamental_infos
    station_timetable_fundamental_infos
  end

  def has_only_one_fundamental_info?
    fundamental_infos.length == 1
  end
end