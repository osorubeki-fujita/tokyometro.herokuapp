class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::FukutoshinLine::Bottom < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation

  def initialize( request , left_columns , columns_next_to_railway_line , right_columns )
    super( request , left_columns , columns_next_to_railway_line , right_columns )
    @position = :bottom
    @class_name = :fukutoshin_tokyu_mm
    @content = ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::FukutoshinLine::Bottom::ToTokyuToyokoAndMinatomiraiLine.new( @request )
  end

end