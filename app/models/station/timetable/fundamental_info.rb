class Station::Timetable::FundamentalInfo < ActiveRecord::Base
  belongs_to :station_timetable_info , class: ::Station::Timetable::Info

  include ::Association::To::Station::Info
  belongs_to :railway_line , class: ::RailwayLine
  belongs_to :operator , class: ::Operator
  belongs_to :railway_direction , class: ::RailwayDirection
end
