module TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Columns

  def columns
    @left_columns + @columns_next_to_railway_line + @right_columns + 1
  end

end