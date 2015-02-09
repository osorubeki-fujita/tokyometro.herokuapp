class TrainTimetableTrainTypeInOtherOperator < ActiveRecord::Base
  belongs_to :train_type
  belongs_to :railway_line
  has_many :train_timetables

  include AssociationFromFromStation
end