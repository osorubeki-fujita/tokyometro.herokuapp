class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::YurakuchoLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::OneRailwayLine

  private

  def additional_info_top
    ::Proc.new {
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::YurakuchoLine::Top.new( @request , @left_columns , @columns_next_to_railway_line , @right_columns ).render
    }
  end

  def set_number_of_left_columns
    @left_columns = 4
  end

  def set_number_of_columns_next_to_railway_line
    @columns_next_to_railway_line = 2
  end

end