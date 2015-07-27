class Operator::AsTrainOwner < ActiveRecord::Base

  belongs_to :info , class: ::Operator::Info
  has_one :code_info , class: ::Operator::CodeInfo , through: :info

  has_many :train_location_infos , class: ::Train::Location::Info , foreign_key: :operator_as_train_owner_id
  has_many :train_timetable_infos , class: ::Train::Timetable::Info , foreign_key: :operator_as_train_owner_id

end
