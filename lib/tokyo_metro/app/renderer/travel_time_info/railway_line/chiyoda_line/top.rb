class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine::Top < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation

  def initialize( request , left_columns , columns_next_to_railway_line , right_columns )
    super( request , left_columns , columns_next_to_railway_line , right_columns )
    @position = :top
    @class_name = :chiyoda_odakyu
    @content = [
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine::Top::ToOdakyuTamaExpress.new( @request ) ,
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine::Top::ToOdakyuSemiExpress.new( @request ) ,
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine::Top::ToOdakyuRomanceCar.new( @request )
    ]
  end

end

# through_operation_info_box