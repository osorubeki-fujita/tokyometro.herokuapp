class TokyoMetro::App::Renderer::PassengerSurvey::SideMenu::Year < TokyoMetro::App::Renderer::PassengerSurvey::SideMenu::MetaClass

  def initialize( request , year )
    super( request )
    @year = year
  end

  private

  def h_locals
    super.merge({
      year: @year
    })
  end

end