class Operator::AdditionalInfo < ActiveRecord::Base
  belongs_to :info , class: ::Operator::Info
  belongs_to :color_info , class: ::Design::Color::Info
end
