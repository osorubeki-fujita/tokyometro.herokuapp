module TrainLocationCommonSettings
  extend ActiveSupport::Concern
  included do
    belongs_to :train_type_in_api
    belongs_to :railway_line
    belongs_to :train_owner
    belongs_to :railway_direction
  end
end