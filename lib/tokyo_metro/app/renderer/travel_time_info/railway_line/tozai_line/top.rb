class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::TozaiLine::Top < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation

  def initialize( request , left_columns , columns_next_to_railway_line , right_columns )
    super( request , left_columns , columns_next_to_railway_line , right_columns )
    @position = :top
    @class_name = :tozai_chuo
    @content = ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::TozaiLine::Top::ToJrChuoLine.new( @request )
  end

end