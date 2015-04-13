class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::NambokuLine::Bottom < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation

  def initialize( request , left_columns , columns_next_to_railway_line , right_columns )
    super( request , left_columns , columns_next_to_railway_line , right_columns )
    @position = :bottom
    @class_name = :namboku_saitama
    @content = ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::NambokuLine::Bottom::ToSaitamaRailwayLine.new( @request )
  end

end