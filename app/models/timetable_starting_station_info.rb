class TimetableStartingStationInfo < ActiveRecord::Base
  has_many :train_times
  belongs_to :station

  def to_s
    self.station.name_ja + "発"
  end
end