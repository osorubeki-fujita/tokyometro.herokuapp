class TrainTypeStoppingPattern < ActiveRecord::Base
  belongs_to :train_type
  belongs_to :stopping_pattern
end