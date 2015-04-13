class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::MultipleRailwayLines

  private

  def set_railway_lines( railway_lines )
    @main_railway_line = railway_lines.find { | railway | railway.same_as == "odpt.Railway:TokyoMetro.Chiyoda" }
    @branch_railway_line = railway_lines.find { | railway | railway.same_as == "odpt.Railway:TokyoMetro.ChiyodaBranch" }
  end

  def railway_line_base
    @main_railway_line
  end

  def additional_info_top
    ::Proc.new {
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine::Top.new( @request , @left_columns , @columns_next_to_railway_line , @right_columns ).render
    }
  end

  def additional_info_bottom
    ::Proc.new {
      ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine::Bottom.new( @request , @left_columns , @columns_next_to_railway_line , @right_columns , @branch_railway_line ).render
    }
  end

  def set_number_of_columns_next_to_railway_line
    @columns_next_to_railway_line = 1
  end

  def set_number_of_right_columns
    @right_columns = 5
  end

end