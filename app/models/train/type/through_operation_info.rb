class Train::Type::ThroughOperationInfo < ActiveRecord::Base

  belongs_to :info , class: ::Train::Type::Info
  belongs_to :railway_line_info , class: ::Railway::Line::Info
  belongs_to :to_station , class: ::Station::Info

end
