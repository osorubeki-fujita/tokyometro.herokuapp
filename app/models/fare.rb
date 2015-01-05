class Fare < ActiveRecord::Base
  belongs_to :normal_fare_group

  include AssociationFromFromStation
  include AssociationFromToStation
end