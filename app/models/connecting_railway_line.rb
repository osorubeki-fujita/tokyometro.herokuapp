class ConnectingRailwayLine < ActiveRecord::Base
  belongs_to :station
  belongs_to :railway_line
  belongs_to :another_station , class_name: 'Station'
  belongs_to :connecting_railway_line_note
end