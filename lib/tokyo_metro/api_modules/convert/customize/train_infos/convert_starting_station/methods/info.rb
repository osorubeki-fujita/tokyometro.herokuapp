module TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ConvertStartingStation::Methods::Info

  private

  def customize_starting_station_same_as_in_db
    @starting_station = ::TokyoMetro::CommonModules::Dictionary::Station.station_same_as_in_db( @starting_station , "Starting station" )
  end

end