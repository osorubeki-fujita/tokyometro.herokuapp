class OperationDay < ActiveRecord::Base
  has_many :women_only_car_info
  has_many :train_times # 【削除予定】
  has_many :train_timetables
end