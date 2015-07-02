class StationPassengerSurvey < ActiveRecord::Base
  include ::Association::To::Station::Info
  belongs_to :passenger_survey
  has_many :station_facility_infos , through: :station_info
end
