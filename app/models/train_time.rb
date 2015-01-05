class TrainTime < ActiveRecord::Base
  belongs_to :timetable
  belongs_to :train_type
  belongs_to :operation_day

  belongs_to :timetable_starting_station_info
  belongs_to :timetable_arrival_info
  belongs_to :timetable_connection_info
  belongs_to :timetable_train_type_in_other_operator

  include AssociationFromToStation

  scope :destination , -> {
    to_station
  }

  def has_additional_info?
    self.is_last or self.is_origin or self.depart_from.meaningful? or self.timetable_starting_station_info_id.meaningful? or self.timetable_arrival_info_id.meaningful?
  end
end