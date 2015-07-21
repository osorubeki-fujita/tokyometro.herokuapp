class Train::Timetable::TrainTypeInOtherOperatorInfo < ActiveRecord::Base
  belongs_to :train_type_info , class: ::Train::Type::Info
  belongs_to :railway_line_info , class: ::Railway::Line::Info
  has_many :train_timetable_infos , class: ::Train::Timetable::Info , foreign_key: :in_other_operator_info_id
  include ::Association::To::FromStation::Info
end
