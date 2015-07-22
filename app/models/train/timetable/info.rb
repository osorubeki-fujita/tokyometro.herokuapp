class Train::Timetable::Info < ActiveRecord::Base
  belongs_to :railway_line_info , class: ::Railway::Line::Info
  belongs_to :operator_info , class: ::Operator::Info
  belongs_to :railway_direction , class: ::Railway::Direction
  belongs_to :train_owner , class: ::TrainOwner
  belongs_to :operation_day , class: ::OperationDay

  belongs_to :starting_station_info , class: ::Station::Info
  belongs_to :terminal_station_info , class: ::Station::Info

  belongs_to :arrival_info , class: ::Train::Timetable::ArrivalInfo
  belongs_to :train_type_in_other_operator , class: ::Train::Timetable::TrainTypeInOtherOperatorInfo
  belongs_to :train_type_info , class: ::Train::Type::Info

  has_many :station_train_times , class: ::Station::TrainTime , foreign_key: :train_timetable_info_id

  include ::OdptCommon::Modules::Decision::Common::RailwayLine::Name
  include ::TokyoMetro::Modules::Decision::Common::RailwayLine::Name

  include ::TokyoMetro::Modules::Decision::Db::TrainType

end
