class TrainTimetable < ActiveRecord::Base
  belongs_to :railway_line
  belongs_to :operator
  belongs_to :railway_direction
  belongs_to :train_owner
  belongs_to :operation_day
  belongs_to :starting_station , class: Station
  belongs_to :terminal_station , class: Station
  belongs_to :train_timetable_arrival_info
  belongs_to :train_timetable_connection_info
  belongs_to :train_timetable_train_type_in_other_operator
  belongs_to :train_type
  belongs_to :train_name , class: TrainType
  has_many :station_train_times

  include ::TokyoMetro::DbModules::Decision::RailwayLine
  include ::TokyoMetro::DbModules::Decision::TrainType

end