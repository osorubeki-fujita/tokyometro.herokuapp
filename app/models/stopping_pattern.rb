class StoppingPattern < ActiveRecord::Base
  has_many :station_stopping_patterns
  has_many :station_infos , through: :station_stopping_patterns

  has_many :train_type_stopping_patterns
  has_many :train_types , through: :station_stopping_patterns
end