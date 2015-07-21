class AirConditioner::Info < ActiveRecord::Base
  belongs_to :answer , class: ::AirConditioner::Answer
  belongs_to :railway_line_info , class: ::Railway::Line::Info
  belongs_to :train_location_info , class: ::Train::Location::Info
end
