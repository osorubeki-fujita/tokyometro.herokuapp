module TokyoMetro::DbModules::Decision::RailwayLine

  include ::TokyoMetro::CommonModules::Info::Decision::RailwayLine

  private

  def on_the_railway_line_of?( *args , compared )
    super( *args , railway_line.same_as )
  end

  alias :is_on_the_railway_line_of? :on_the_railway_line_of?

end