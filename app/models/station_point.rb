class StationPoint < ActiveRecord::Base
  include ::Association::To::Station::Info
  belongs_to :point
end