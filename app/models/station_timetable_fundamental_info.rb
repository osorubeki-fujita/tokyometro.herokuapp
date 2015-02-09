class StationTimetableFundamentalInfo < ActiveRecord::Base
  belongs_to :station_timetable

  belongs_to :station
  belongs_to :railway_line
  belongs_to :operator
  belongs_to :railway_direction
end