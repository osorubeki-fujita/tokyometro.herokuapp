class TokyoMetro::App::Renderer::PassengerSurvey::Table::MetaClass < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , passenger_survey_infos , make_graph )
    super( request )
    @passenger_survey_infos = passenger_survey_infos
    @make_graph = make_graph

    set_max_passenger_journey_in_graph
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :passenger_survey_table , class: css_class_name_of_tables }
  %table{ class: [ :table , "table-striped" ] }
    = this.render_header_of_table
    - rows.each do | row |
      = row.render
    HAML
  end

  def render_header_of_table
    raise "Error: This method \'#{ __method__ }\' is not defined in this class \'#{ self.class.name }\'."
  end

  private

  def set_max_passenger_journey_in_graph
    base = 20000
    @max_passenger_journey_in_graph = ( @passenger_survey_infos.pluck( :passenger_journeys ).max * 1.0 / base ).ceil * base
  end

  def rows
    @passenger_survey_infos.map.with_index(1) { | passenger_survey_info , i |
      class_name_of_each_row.new( *( variables_send_to_row_instance( passenger_survey_info , i ) ) )
    }
  end

  def class_name_of_each_row
    raise "Error: This method \'#{ __method__ }\' is not defined in this class \'#{ self.class.name }\'."
  end

  def variables_send_to_row_instance( passenger_survey_info , i )
    [ @request , passenger_survey_info , i , @max_passenger_journey_in_graph , @make_graph ]
  end

  def h_locals
    super.merge({
      this: self ,
      rows: rows ,
      css_class_name_of_tables: @css_class_name_of_tables
    })
  end

end