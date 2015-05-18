class StationPoint < ActiveRecord::Base

  include ::Association::To::Station::Info
  belongs_to :point_info , class: ::Point::Info

end