class Station::PassengerSurvey < ActiveRecord::Base
  include ::Association::To::Station::Info
  belongs_to :passenger_survey , class: ::PassengerSurvey

  has_many :station_facility_infos , through: :station_info , class: ::Station::Facility::Info
end
