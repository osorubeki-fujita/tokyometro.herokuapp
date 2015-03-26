class TrainLocation < ActiveRecord::Base
  include TrainLocationCommonSettings
  include ::Association::To::FromStation::Info
  include ::Association::To::ToStation::Info
  has_many :air_conditioner_infos
end