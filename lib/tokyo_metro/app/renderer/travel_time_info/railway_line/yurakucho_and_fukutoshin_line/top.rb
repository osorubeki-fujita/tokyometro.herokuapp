class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::YurakuchoAndFukutoshinLine::Top < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation

  def initialize( request , left_columns , columns_next_to_railway_line , right_columns )
    super( request , left_columns , columns_next_to_railway_line , right_columns )
    @position = :top
  end

  private

  def h_locals
    h_locals_base.merge({
      seibu_ikebukuro_line: ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::YurakuchoAndFukutoshinLine::Top::ToSeibuIkebukuroLine.new( @request ) ,
      tobu_tojo_line: ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::YurakuchoAndFukutoshinLine::Top::ToTobuTojoLine.new( @request )
    })
  end

end