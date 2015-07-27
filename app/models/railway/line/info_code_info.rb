class Railway::Line::InfoCodeInfo < ActiveRecord::Base

  belongs_to :info , class: ::Railway::Line::Info
  belongs_to :code_info , class: ::Railway::Line::CodeInfo

  belongs_to :from_station , class: ::Station::Info
  belongs_to :to_station , class: ::Station::Info

end
