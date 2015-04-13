module TokyoMetro::App::Renderer::StationFacility::Platform::Info::MultipleRailwayLines::Common

  attr_reader :railway_lines

  def railway_line_info
    @railway_lines
  end

  private

  def set_railway_line( railway_lines )
    @railway_lines = railway_lines
  end

end