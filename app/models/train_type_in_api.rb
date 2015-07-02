class TrainTypeInApi < ActiveRecord::Base
  has_many :train_types

  has_many :train_locations
  has_many :train_location_olds
end