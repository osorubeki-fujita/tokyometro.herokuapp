module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::CurrentStation

  include ::TokyoMetro::CommonModules::Decision::CurrentStation

  private

  def station_same_as__is_in?( *variables )
    super( *variables , @station_instance.same_as )
  end

end