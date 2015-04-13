class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::FukutoshinLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::OneRailwayLine

  private

  def additional_info_top
    ::Proc.new {
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::FukutoshinLine::Top.new( @request , @left_columns , @columns_next_to_railway_line , @right_columns ).render
    }
  end

  def additional_info_bottom
    ::Proc.new {
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::FukutoshinLine::Bottom.new( @request , @left_columns , @columns_next_to_railway_line , @right_columns ).render
    }
  end

  def set_number_of_left_columns
    @left_columns = 4
  end

  def set_number_of_columns_next_to_railway_line
    @columns_next_to_railway_line = 2
  end

  def set_number_of_right_columns
    @right_columns = 4
  end

end