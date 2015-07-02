class Fare < ActiveRecord::Base
  belongs_to :normal_fare_group
  include ::Association::To::FromStation::Info
  include ::Association::To::ToStation::Info
end