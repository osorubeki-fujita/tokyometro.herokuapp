module TokyoMetro::ApiModules::Decision::RailwayLine

  include ::TokyoMetro::CommonModules::Decision::RailwayLine
  
  private

  def is_on_the_railway_line_of?( *variables )
    super( *variables , @railway_line )
  end

end