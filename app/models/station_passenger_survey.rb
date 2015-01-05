class StationPassengerSurvey < ActiveRecord::Base
  has_many :station_facilities , through: :station
  belongs_to :station
  belongs_to :passenger_survey
end