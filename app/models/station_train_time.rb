class StationTrainTime < ActiveRecord::Base
  belongs_to :station_timetable
  belongs_to :train_timetable
  belongs_to :train_type_in_this_station , class: TrainType
  belongs_to :station_timetable_starting_station_info

  belongs_to :station_timetable_starting_station_info
  belongs_to :station_timetable_connection_info

  def is_last?
    is_last
  end

  [ :last? , :last_train? , :is_last_train? ].each do | method_name |
    eval <<-ALIAS
      alias :#{ method_base_name } :is_last?
    ALIAS
  end

  def has_departing_platform_info?
    platform_number.meaningful?
  end

  def has_station_timetable_starting_station_info?
    station_timetable_starting_station_info_id.meaningful?
  end

  def has_train_timetable_arrival_info?
    train_timetable_arrival_info_id.meaningful?
  end

  def train_timetable_arrival_info_id
    train_timetable.train_timetable_arrival_info_id
  end

  def train_timetable_arrival_info
    train_timetable.train_timetable_arrival_info
  end

  def has_additional_infos?
    last_train? or self.is_origin or has_departing_platform_info? or has_station_timetable_starting_station_info? or has_train_timetable_arrival_info?
  end

end