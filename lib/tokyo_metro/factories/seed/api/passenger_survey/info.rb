class TokyoMetro::Factories::Seed::Api::PassengerSurvey::Info < TokyoMetro::Factories::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::PassengerSurvey
  include ::TokyoMetro::Factories::Seed::Api::PassengerSurvey::Common
  include ::TokyoMetro::Factories::Seed::Reference::Operator

  private

  def hash_to_db
    h = ::Hash.new
    h[ :operator_id ] = operator_id
    [ :id_urn , :same_as , :survey_year , :passenger_journeys ].each do | key_name |
      h[ key_name ] = @info.send( key_name )
    end
    h
  end

end