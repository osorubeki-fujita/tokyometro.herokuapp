class TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::MultipleRailwayLines < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , railway_lines )
    super( request )
    set_railway_lines( railway_lines )
    common_procedures_when_initialize
  end

  include ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Columns
  include ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Common

  private

  def h_locals
    super.merge({
      railway_line: @main_railway_line ,
      rows: rows ,
      additional_info_top: additional_info_top ,
      additional_info_bottom: additional_info_bottom
    })
  end

  def set_railway_lines( railway_lines )
    @railway_lines = railway_lines
  end

  def h_locals
    super.merge({
      railway_lines: @railway_lines
    })
  end

end