class TrainLocationOld < ActiveRecord::Base
  include TrainLocationCommonSettings
  include AssociationFromFromStation
  include AssociationFromToStation
end