class AirConditioner::Info < ActiveRecord::Base
  belongs_to :answer , class: ::AirConditioner::Answer
  belongs_to :railway_line
  belongs_to :train_location_data , polymorphic: true
end