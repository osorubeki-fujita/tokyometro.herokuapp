class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::MarunouchiLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::MultipleRailwayLines

  private

  def set_railway_lines( railway_lines )
    @main_railway_line = railway_lines.find { | railway | railway.same_as == "odpt.Railway:TokyoMetro.Marunouchi" }
    @branch_railway_line = railway_lines.find { | railway | railway.same_as == "odpt.Railway:TokyoMetro.MarunouchiBranch" }
  end

  def railway_line_base
    @main_railway_line
  end

  def set_number_of_columns_next_to_railway_line
    @columns_next_to_railway_line = 9
  end

end