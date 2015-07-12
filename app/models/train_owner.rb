class TrainOwner < ActiveRecord::Base
  belongs_to :operator

  has_many :train_locations
  has_many :train_timetables
end
