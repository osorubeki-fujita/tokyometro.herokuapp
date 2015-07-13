class TrainOwner < ActiveRecord::Base
  belongs_to :operator

  has_many :train_location_infos , class: ::Train::Location::Info , foreign_key: :train_owner_id
  has_many :train_timetables
end
