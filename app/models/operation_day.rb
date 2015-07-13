class OperationDay < ActiveRecord::Base
  has_many :women_only_car_info
  has_many :train_timetable_infos , class: ::Train::Timetable::Info , foreign_key: :operation_day_id
end
