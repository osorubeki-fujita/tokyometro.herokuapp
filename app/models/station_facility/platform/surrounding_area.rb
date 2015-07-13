class StationFacility::Platform::SurroundingArea < ActiveRecord::Base
  belongs_to :platform_info , class: ::StationFacility::Platform::Info
  belongs_to :surrounding_area , class: ::SurroundingArea
end
