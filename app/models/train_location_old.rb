class TrainLocationOld < ActiveRecord::Base
  include TrainLocationCommonSettings
  include ::Association::To::FromStation::Info
  include ::Association::To::ToStation::Info
end