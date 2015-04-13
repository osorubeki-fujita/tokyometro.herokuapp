class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::HibiyaLine::Bottom < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation

  def initialize( request , left_columns , columns_next_to_railway_line , right_columns )
    super( request , left_columns , columns_next_to_railway_line , right_columns )
    @position = :bottom
    @class_name = :hibiya_tobu
    @content = ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::HibiyaLine::Bottom::ToTobuLine.new( @request )
  end

end