module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::RailwayLine

  include ::TokyoMetro::CommonModules::Decision::RailwayLine

  private

  def is_on_the_railway_line_of?( *variables )
    super( *variables , @railway_line_instance.same_as )
  end

end