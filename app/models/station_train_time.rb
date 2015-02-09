class StationTrainTime < ActiveRecord::Base
  belongs_to :station_timetable
  belongs_to :train_timetable
  belongs_to :train_type_in_this_station , class: TrainType
  belongs_to :station_timetable_starting_station_info

  belongs_to :station_timetable_starting_station_info
  belongs_to :station_timetable_connection_info
  
  def train_timetable_arrival_info
    train_timetable.train_timetable_arrival_info_id
  end

  def has_additional_info?
    self.is_last or self.is_origin or self.platform.meaningful? or self.station_timetable_starting_station_info_id.meaningful? or self.train_timetable_arrival_info_id.meaningful?
  end

end