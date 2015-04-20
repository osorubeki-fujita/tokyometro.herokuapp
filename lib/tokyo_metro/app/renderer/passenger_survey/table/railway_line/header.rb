class TokyoMetro::App::Renderer::PassengerSurvey::Table::RailwayLine::Header < TokyoMetro::App::Renderer::PassengerSurvey::Table::MetaClass::Header

  def initialize( reqeust , make_graph , railway_line )
    super( reqeust , make_graph )
    @railway_line = railway_line
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%thead{ id: :header_of_passenger_survey_table }
  = this.render_header_of_order
  = this.render_header_of_station
  = this.render_header_of_year
  = this.render_header_of_passenger_journeys
    HAML
  end
  
  def render_header_of_order
    h.render inline: <<-HAML , type: :haml , locals: { railway_line: @railway_line }
%td{ class: :order , colspan: 2 }<
  %p<
    = "順位"
  %p{ class: :small }<
    = "左：" + railway_line.name_ja
  %p{ class: :small }<
    = "右：全路線"
    HAML
  end

end