class Operator::CodeInfo < ActiveRecord::Base
  belongs_to :info , class: ::Operator::Info
end
