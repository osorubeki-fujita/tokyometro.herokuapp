class TokyoMetro::Api::Station::Info::LinkToPassengerSurvey::Info < TokyoMetro::Api::Station::Info::Common::Info

  def initialize( survey )
    @survey = survey
  end

  attr_reader :survey

  def self.factory_for_this_class
    factory_for_generating_link_to_passenger_survey_from_string
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_link_to_passenger_survey
  end

end