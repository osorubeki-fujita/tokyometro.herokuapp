class Railway::Line::InfoCode < ActiveRecord::Base

  belongs_to :info , class: ::Railway::Line::Info
  belongs_to :code , class: ::Railway::Line::Code

  belongs_to :from_station , class: ::Station::Info
  belongs_to :to_station , class: ::Station::Info

end
