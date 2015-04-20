class TokyoMetro::App::Renderer::PassengerSurvey::Table::MetaClass::Header < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , make_graph )
    super( request )
    @make_graph = make_graph
  end

  def render
    raise "Error: This method \'#{ __method__ }\' is not defined in this class \'#{ self.class.name }\'."
  end
  
  def render_header_of_order
    h.render inline: <<-HAML , type: :haml
%td{ class: :order }<
  = "順位"
    HAML
  end
  
  def render_header_of_station
    h.render inline: <<-HAML , type: :haml
%td{ class: :station }<
  = "駅"
    HAML
  end

  def render_header_of_year
    h.render inline: <<-HAML , type: :haml
%td{ class: :survey_year }<
  %p<
    = "調査"
  %p<
    = "年度"
    HAML
  end
  
  def render_header_of_passenger_journeys
    h.render inline: <<-HAML , type: :haml , locals: { make_graph: @make_graph }
- if make_graph
  %td{ colspan: 2 , class: :passenger_journeys }<
    = "乗降客数"
- else
  %td{ class: :passenger_journeys }<
    = "乗降客数"
    HAML
  end
  
  private
  
  def h_locals
    super.merge({
      this: self
    })
  end

end