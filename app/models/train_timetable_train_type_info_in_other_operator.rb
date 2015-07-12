class TrainTimetableTrainTypeInfoInOtherOperator < ActiveRecord::Base
  belongs_to :train_type_info , class: ::TrainType::Info
  belongs_to :railway_line , class: ::RailwayLine
  has_many :train_timetables , class: ::TrainTimetable , foreign_key: :train_timetable_train_type_info_in_other_operator_id
  include ::Association::To::FromStation::Info
end
