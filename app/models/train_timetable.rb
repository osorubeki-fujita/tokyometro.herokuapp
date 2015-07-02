class TrainTimetable < ActiveRecord::Base
  belongs_to :railway_line
  belongs_to :operator
  belongs_to :railway_direction
  belongs_to :train_owner
  belongs_to :operation_day

  belongs_to :starting_station_info , class: ::Station::Info
  belongs_to :terminal_station_info , class: ::Station::Info

  belongs_to :train_timetable_arrival_info
  belongs_to :train_timetable_connection_info
  belongs_to :train_timetable_train_type_in_other_operator
  belongs_to :train_type
  belongs_to :train_name , class: TrainType
  has_many :station_train_times

  include ::TokyoMetro::Modules::Db::Decision::RailwayLine
  include ::TokyoMetro::Modules::Db::Decision::TrainType

end
