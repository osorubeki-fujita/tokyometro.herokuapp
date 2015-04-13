class TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::OneRailwayLine < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , railway_line )
    super( request )
    set_railway_line( railway_line )
    common_procedures_when_initialize
  end

  include ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Columns
  include ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Common

  private

  def set_railway_line( railway_line )
    @railway_line = railway_line
  end

  def railway_line_base
    @railway_line
  end

end