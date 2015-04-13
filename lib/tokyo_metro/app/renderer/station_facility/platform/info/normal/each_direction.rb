class TokyoMetro::App::Renderer::StationFacility::Platform::Info::Normal::EachDirection < TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::EachDirection

  include ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::Normal::Common

  private

  def set_railway_line( railway_line )
    @railway_line = railway_line
  end

end