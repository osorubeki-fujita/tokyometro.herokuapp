class StationTimetableFundamentalInfo < ActiveRecord::Base
  belongs_to :station_timetable

  include ::Association::To::Station::Info
  belongs_to :railway_line
  belongs_to :operator
  belongs_to :railway_direction
end