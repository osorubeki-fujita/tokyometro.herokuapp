class Train::Operation::Info < ActiveRecord::Base
  belongs_to :operator , class: ::Operator
  belongs_to :railway_line , class: ::RailwayLine
  belongs_to :status , class: ::Train::Operation::Status
  belongs_to :text , class: ::Train::Operation::Text
end
