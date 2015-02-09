class TokyoMetro::Factories::Seed::Api::Station::Info::LinkToPassengerSurvey::Info < TokyoMetro::Factories::Seed::Api::Station::Info::Common::Info

  include ::TokyoMetro::Factories::Seed::Reference::PassengerSurvey

  private

  def hash_to_db
    {
      passenger_survey_id: passenger_survey_id ,
      station_id: @station_id
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_link_to_passenger_survey
  end

end