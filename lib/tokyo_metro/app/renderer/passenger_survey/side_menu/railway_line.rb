class TokyoMetro::App::Renderer::PassengerSurvey::SideMenu::RailwayLine < TokyoMetro::App::Renderer::PassengerSurvey::SideMenu::MetaClass

  def initialize( request , railway_lines )
    super( request )
    @railway_lines = railway_lines
  end

  private

  def h_locals
    super.merge({
      railway_lines: @railway_lines
    })
  end

end