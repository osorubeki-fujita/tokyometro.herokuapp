class TokyoMetro::App::Renderer::PassengerSurvey::Table::RailwayLine::Row < TokyoMetro::App::Renderer::PassengerSurvey::Table::MetaClass::Row

  def initialize(
    request ,
    passenger_survey_info , n , max_passenger_journey_in_graph , make_graph ,
    passenger_survey_infos_of_the_same_railway_line , passenger_survey_infos_of_the_same_operator , railway_lines_including_branch
  )
    super( request , passenger_survey_info , n , max_passenger_journey_in_graph , make_graph )
    
    set_order( passenger_survey_infos_of_the_same_railway_line , passenger_survey_infos_of_the_same_operator )
    
    @station_info = passenger_survey_info.station_infos.where( railway_line_id: railway_lines_including_branch.map( &:id ) ).first
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%tr{ class: [ :passenger_survey_table_row , cycle( :odd_row , :even_row ) ] , "data-href" => passenger_survey_info.station_page_name }
  - passenger_survey_info_decorated = passenger_survey_info.decorate
  = this.render_order
  = passenger_survey_info_decorated.render_station_name_in_table( station_info )
  = passenger_survey_info_decorated.render_survey_year_in_table
  = passenger_survey_info_decorated.render_passenger_journeys
  = this.render_svg_domain_in_table
    HAML
  end

  def render_order
    h.render inline: <<-HAML , type: :haml , locals: h_locals_for_order
%td{ class: [ td_classes_of_cell_for_the_same_railway_line , :railway_line ].flatten }<
  = order_in_the_same_railway_line
%td{ class: [ td_classes_of_cell_for_the_same_operator , :all ].flatten }<
  = "(" + order_in_the_same_operator.to_s + ")"
    HAML
  end

  private

  def h_locals
    super.merge({
      station_info: @station_info
    })
  end

  def h_locals_for_order
    {
      td_classes_of_cell_for_the_same_railway_line: td_classes_of_order( @order_in_the_same_railway_line ) ,
      td_classes_of_cell_for_the_same_operator: [ :order , :text_en ] ,
      order_in_the_same_railway_line: @order_in_the_same_railway_line ,
      order_in_the_same_operator: @order_in_the_same_operator
    }
  end

  def set_order( passenger_survey_infos_of_the_same_railway_line , passenger_survey_infos_of_the_same_operator )
    @order_in_the_same_railway_line = passenger_survey_infos_of_the_same_railway_line.where( 'passenger_journeys > ?' , @passenger_survey_info.passenger_journeys ).count + 1
    @order_in_the_same_operator = passenger_survey_infos_of_the_same_operator.where( 'passenger_journeys > ?' , @passenger_survey_info.passenger_journeys ).count + 1
  end

end