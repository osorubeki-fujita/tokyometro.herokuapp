module TokyoMetro::Modules::Api::Info::Decision::RailwayLine

  include ::TokyoMetro::Modules::Common::Info::Decision::RailwayLine

  private

  def on_the_railway_line_of?( *args , compared: @railway_line )
    raise if args.empty?
    super( *args , compared )
  end

  alias :is_on_the_railway_line_of? :on_the_railway_line_of?

end