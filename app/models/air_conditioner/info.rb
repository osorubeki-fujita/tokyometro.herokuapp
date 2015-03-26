class AirConditioner::Info < ActiveRecord::Base
  belongs_to :air_conditioner_answer
  belongs_to :railway_line
  belongs_to :train_location
end