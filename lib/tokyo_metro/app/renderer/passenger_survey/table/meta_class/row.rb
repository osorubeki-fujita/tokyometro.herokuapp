class TokyoMetro::App::Renderer::PassengerSurvey::Table::MetaClass::Row < TokyoMetro::App::Renderer::MetaClass

  @@rectangle_height = 20

  def self.rectangle_height
    @@rectangle_height
  end

  def initialize( request , passenger_survey_info , n , max_passenger_journey_in_graph , make_graph )
    super( request )
    @passenger_survey_info = passenger_survey_info
    @number = n
    @max_passenger_journey_in_graph = max_passenger_journey_in_graph
    @make_graph = make_graph
  end

  def render
    raise "Error: This method \'#{ __method__ }\' is not defined in this class \'#{ self.class.name }\'."
  end

  def render_order
    h.render inline: <<-HAML , type: :haml , locals: h_locals_for_order
%td{ class: td_classes }<
  = order
    HAML
  end

  def render_svg_domain_in_table
    h.render inline: <<-HAML , type: :haml , locals: { make_graph: @make_graph , svg_id: svg_id , passenger_journeys: @passenger_survey_info.passenger_journeys , height_of_svg_rectangle: @@rectangle_height }
- if make_graph
  %td{ class: :graph }
    %svg{ id: svg_id , passenger_journeys: passenger_journeys }
      = tag( :rect , x: 0 , y: 0 , width: 0 , height: height_of_svg_rectangle )
    HAML
  end

  private

  def h_locals
    super.merge({
      this: self ,
      passenger_survey_info: @passenger_survey_info
    })
  end

  def svg_id
    "passengers_#{ @number }_#{ @passenger_survey_info.station_name_in_system.underscore }"
  end

  def set_order( whole_passenger_survey_infos)
    @order = whole_passenger_survey_infos.where( 'passenger_journeys > ?' , @passenger_survey_info.passenger_journeys ).count + 1
  end
  
  def h_locals_for_order
    { td_classes: td_classes_of_order , order: @order }
  end
  
  def td_classes_of_order( order = @order )
    ary = [ :order , :text_en ]
    unless order == @number
      ary << [ :tie ]
    end
    ary
  end

end