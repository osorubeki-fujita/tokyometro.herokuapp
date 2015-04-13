class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::NambokuLine::Top < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation

  def initialize( request , left_columns , columns_next_to_railway_line , right_columns )
    super( request , left_columns , columns_next_to_railway_line , right_columns )
    @position = :top
    @class_name = :namboku_tokyu
    @content = ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::NambokuLine::Top::ToTokyuMeguroLine.new( @request )
  end

end