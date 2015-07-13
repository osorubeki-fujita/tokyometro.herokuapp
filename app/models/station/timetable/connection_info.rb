class Station::Timetable::ConnectionInfo < ActiveRecord::Base
  has_many :station_train_times , class: ::Station::TrainTime , foreign_key: :station_timetable_connection_info_id
  include ::Association::To::Station::Info
end
