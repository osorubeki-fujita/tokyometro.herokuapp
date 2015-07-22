class Train::Operation::Info < ActiveRecord::Base
  belongs_to :operator_info , class: ::Operator::Info
  belongs_to :railway_line_info , class: ::Railway::Line::Info

  belongs_to :status , class: ::Train::Operation::Status
  belongs_to :text , class: ::Train::Operation::Text
end
