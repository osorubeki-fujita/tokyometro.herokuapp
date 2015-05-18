module TrainLocationInfoCommonSettings
  extend ActiveSupport::Concern
  included do
    belongs_to :train_type_in_api , class: ::TrainTypeInApi
    belongs_to :railway_line , class: ::RailwayLine
    belongs_to :train_owner , class: ::TrainOwner
    belongs_to :railway_direction , class: ::RailwayDirection
    has_many :air_conditioner_infos , class: ::AirConditioner::Info , as: :train_location_data
  end
end