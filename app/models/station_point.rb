class StationPoint < ActiveRecord::Base

  include ::Association::To::Station::Info
  include ::Association::To::Point::Info

end