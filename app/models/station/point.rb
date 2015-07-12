class Station::Point < ActiveRecord::Base

  include ::Association::To::Station::Info
  include ::Association::To::Point::Info

end
