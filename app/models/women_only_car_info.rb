class WomenOnlyCarInfo < ActiveRecord::Base
  belongs_to :operation_day

  include AssociationFromFromStation
  include AssociationFromToStation
end