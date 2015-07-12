class StoppingPattern < ActiveRecord::Base
  has_many :station_stopping_pattern_infos , class: ::Station::StoppingPattern::Info
  has_many :station_infos , through: :station_stopping_pattern_infos , class: ::Station::Info

  has_many :train_type_stopping_patterns , class: ::TrainType::StoppingPattern , foreign_key: :stopping_pattern_id
  has_many :train_type_infos , through: :train_type_stopping_patterns , class: ::TrainType::Info
end
