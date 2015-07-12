class TrainType::StoppingPattern < ActiveRecord::Base
  belongs_to :train_type_info , class: ::TrainType::Info
  belongs_to :stopping_pattern , class: ::StoppingPattern
  belongs_to :railway_line , class: ::RailwayLine
end
