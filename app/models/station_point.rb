class StationPoint < ActiveRecord::Base
  belongs_to :station
  belongs_to :point
end