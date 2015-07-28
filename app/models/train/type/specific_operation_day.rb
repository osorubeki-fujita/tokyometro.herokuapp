class Train::Type::SpecificOperationDay < ActiveRecord::Base
  belongs_to :train_type_info , class: ::Train::Type::Info
  belongs_to :specific_operation_day , class: ::OperationDay
end
