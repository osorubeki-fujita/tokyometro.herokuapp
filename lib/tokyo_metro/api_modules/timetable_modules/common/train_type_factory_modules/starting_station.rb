module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::StartingStation

  include ::TokyoMetro::CommonModules::Decision::StartingStation

  private

  def is_starting?( regexp )
    super( regexp , @starting_station_instance.same_as )
  end

end