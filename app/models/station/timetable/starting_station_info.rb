class Station::Timetable::StartingStationInfo < ActiveRecord::Base
  # has_many :train_times
  has_many :station_train_times , class: ::Station::TrainTime , foreign_key: :station_timetable_starting_station_info_id
  include ::Association::To::Station::Info

  def to_s
    "#{ station_info.name_ja_actual }始発"
  end

end
