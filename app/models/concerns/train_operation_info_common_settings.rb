module TrainOperationInfoCommonSettings
  extend ActiveSupport::Concern
  included do
    belongs_to :operator , class: ::Operator
    belongs_to :railway_line , class: ::RailwayLine
    belongs_to :status , class: ::TrainOperation::Status
    belongs_to :text , class: ::TrainOperation::Text
  end
end
