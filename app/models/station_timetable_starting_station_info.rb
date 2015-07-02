class StationTimetableStartingStationInfo < ActiveRecord::Base
  # has_many :train_times
  has_many :station_train_times
  include ::Association::To::Station::Info

  def to_s
    "#{ station_info.decorate.name_ja_actual }始発"
  end

end