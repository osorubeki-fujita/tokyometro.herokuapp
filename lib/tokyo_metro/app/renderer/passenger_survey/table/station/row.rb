class TokyoMetro::App::Renderer::PassengerSurvey::Table::Station::Row < TokyoMetro::App::Renderer::PassengerSurvey::Table::MetaClass::Row

  def initialize(
    request ,
    passenger_survey_info , n , max_passenger_journey_in_graph , make_graph ,
    passenger_survey_infos_all
  )
    super( request , passenger_survey_info , n , max_passenger_journey_in_graph , make_graph )
    
    set_order( passenger_survey_infos_all )
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%tr{ class: [ :passenger_survey_table_row , cycle( :odd_row , :even_row ) ] , "data-href" => passenger_survey_info.station_page_name }
  - passenger_survey_info_decorated = passenger_survey_info.decorate
  = passenger_survey_info_decorated.render_station_name_in_table
  = passenger_survey_info_decorated.render_survey_year_in_table
  = passenger_survey_info_decorated.render_passenger_journeys
  = this.render_svg_domain_in_table
  = this.render_order
    HAML
  end

  def set_order( passenger_survey_infos_all)
    @order = passenger_survey_infos_all.where( 'survey_year = ? AND passenger_journeys > ?' , @passenger_survey_info.survey_year , @passenger_survey_info.passenger_journeys ).count + 1
  end

end