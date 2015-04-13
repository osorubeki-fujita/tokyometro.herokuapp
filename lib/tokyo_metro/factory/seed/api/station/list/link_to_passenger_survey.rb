class TokyoMetro::Factory::Seed::Api::Station::List::LinkToPassengerSurvey < TokyoMetro::Factory::Seed::Api::Station::List::Common

  private

  def method_for_seeding_each_item
    :seed_link_to_passenger_surveys
  end

end