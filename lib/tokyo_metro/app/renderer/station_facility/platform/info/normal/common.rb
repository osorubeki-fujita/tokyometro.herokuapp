module TokyoMetro::App::Renderer::StationFacility::Platform::Info::Normal::Common

  attr_reader :railway_line

  def railway_line_name_ja
    @railway_line.name_ja
  end

  def railway_line_name_en
    @railway_line.name_en
  end

  def railway_line_css_class_name
    @railway_line.css_class_name
  end

  def railway_line_info
    @railway_line
  end

end