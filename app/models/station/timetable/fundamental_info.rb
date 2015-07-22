class Station::Timetable::FundamentalInfo < ActiveRecord::Base
  belongs_to :station_timetable_info , class: ::Station::Timetable::Info

  include ::Association::To::Station::Info
  belongs_to :railway_line_info , class: ::Railway::Line::Info
  belongs_to :operator_info , class: ::Operator::Info
  belongs_to :railway_direction , class: ::Railway::Direction
end
