class Operator::Code < ActiveRecord::Base
  belongs_to :info , class: ::Operator::Info
end
