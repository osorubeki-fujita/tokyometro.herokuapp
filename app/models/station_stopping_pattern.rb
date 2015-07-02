class StationStoppingPattern < ActiveRecord::Base
  include ::Association::To::Station::Info
  belongs_to :stopping_pattern
  has_many :train_types
  belongs_to :station_stopping_pattern_note
end