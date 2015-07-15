class Station::Facility::Platform::SurroundingArea < ActiveRecord::Base
  belongs_to :platform_info , class: ::Station::Facility::Platform::Info
  belongs_to :surrounding_area , class: ::SurroundingArea
end
