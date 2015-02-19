module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStartingStation::Methods::Info

  private

  def customize_starting_station_same_as_in_db
    @starting_station = ::TokyoMetro::Modules::Common::Dictionary::Station.station_same_as_in_db( @starting_station , "Starting station" )
  end

end