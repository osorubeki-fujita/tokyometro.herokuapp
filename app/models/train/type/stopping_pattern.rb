class Train::Type::StoppingPattern < ActiveRecord::Base
  belongs_to :train_type_info , class: ::Train::Type::Info
  belongs_to :stopping_pattern , class: ::StoppingPattern
  belongs_to :railway_line , class: ::RailwayLine
end
