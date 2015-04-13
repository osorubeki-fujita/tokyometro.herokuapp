class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::NambokuLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::OneRailwayLine

  private

  def set_number_of_left_columns
    @left_columns = 4
  end

  def additional_info_top
    ::Proc.new {
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::NambokuLine::Top.new( @request , @left_columns , @columns_next_to_railway_line , @right_columns ).render
    }
  end

  def additional_info_bottom
    ::Proc.new {
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::NambokuLine::Bottom.new( @request , @left_columns , @columns_next_to_railway_line , @right_columns ).render
    }
  end

end