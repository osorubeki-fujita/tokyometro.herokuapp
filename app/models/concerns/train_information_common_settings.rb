module TrainOperationCommonSettings
  extend ActiveSupport::Concern
  included do
    belongs_to :train_operation_status
    belongs_to :operator
    belongs_to :railway_line
  end
end
