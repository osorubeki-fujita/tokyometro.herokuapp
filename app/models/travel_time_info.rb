class TravelTimeInfo < ActiveRecord::Base
  include AssociationFromFromStation
  include AssociationFromToStation
end