class TimetableTrainTypeInOtherOperator < ActiveRecord::Base
  belongs_to :train_type
  belongs_to :railway_line

  include AssociationFromFromStation
end