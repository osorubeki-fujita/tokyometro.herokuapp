class TrainLocation < ActiveRecord::Base
  include TrainLocationCommonSettings
  include AssociationFromFromStation
  include AssociationFromToStation
end