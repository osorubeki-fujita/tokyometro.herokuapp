class Operator::AsTrainOwner < ActiveRecord::Base

  belongs_to :operator_info , class: ::Operator::Info

  has_many :train_location_infos , class: ::Train::Location::Info , foreign_key: :operator_as_train_owner_id
  has_many :train_timetable_infos , class: ::Train::Timetable::Info , foreign_key: :operator_as_train_owner_id

  def Info
    operator_info
  end

end
