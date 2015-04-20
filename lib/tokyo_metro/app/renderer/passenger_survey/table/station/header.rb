class TokyoMetro::App::Renderer::PassengerSurvey::Table::Station::Header < TokyoMetro::App::Renderer::PassengerSurvey::Table::MetaClass::Header

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%thead{ id: :header_of_passenger_survey_table }
  = this.render_header_of_station
  = this.render_header_of_year
  = this.render_header_of_passenger_journeys
  = this.render_header_of_order
    HAML
  end

end