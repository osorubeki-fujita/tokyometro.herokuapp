class TrainTime < ActiveRecord::Base
  belongs_to :station_timetable
  belongs_to :train_type
  belongs_to :operation_day

  belongs_to :station_timetable_starting_station_info
  belongs_to :train_timetable_arrival_info
  belongs_to :train_timetable_connection_info
  belongs_to :train_timetable_train_type_in_other_operator

  include AssociationFromToStation

  scope :destination , -> {
    to_station
  }

  def has_additional_info?
    self.is_last or self.is_origin or self.depart_from.meaningful? or self.station_timetable_starting_station_info_id.meaningful? or self.train_timetable_arrival_info_id.meaningful?
  end
end