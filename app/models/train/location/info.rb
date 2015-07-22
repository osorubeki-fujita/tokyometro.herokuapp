class Train::Location::Info < ActiveRecord::Base
  belongs_to :train_type_info , class: ::Train::Type::Info
  belongs_to :railway_line_info , class: ::Railway::Line::Info
  belongs_to :operator_as_train_owner , class: ::Operator::AsTrainOwner
  belongs_to :railway_direction , class: ::Railway::Direction

  include ::Association::To::FromStation::Info
  include ::Association::To::ToStation::Info

  has_many :air_conditioner_infos , class: ::AirConditioner::Info , as: :train_location_data
end
