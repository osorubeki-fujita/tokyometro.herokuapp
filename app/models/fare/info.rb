class Fare::Info < ActiveRecord::Base
  belongs_to :normal_group , class: ::Fare::NormalGroup
  include ::Association::To::FromStation::Info
  include ::Association::To::ToStation::Info
end
