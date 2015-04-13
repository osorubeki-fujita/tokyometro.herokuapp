class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::HibiyaLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::OneRailwayLine

  private

  def additional_info_bottom
    ::Proc.new {
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::HibiyaLine::Bottom.new( @request , @left_columns , @columns_next_to_railway_line , @right_columns ).render
    }
  end

end