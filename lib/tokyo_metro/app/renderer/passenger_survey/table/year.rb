class TokyoMetro::App::Renderer::PassengerSurvey::Table::Year < TokyoMetro::App::Renderer::PassengerSurvey::Table::MetaClass

  def initialize( request , passenger_survey_infos , make_graph )
    super( request , passenger_survey_infos , make_graph )
    @css_class_name_of_tables = :tokyo_metro
  end

  def render_header_of_table
    ::TokyoMetro::App::Renderer::PassengerSurvey::Table::Year::Header.new( @reqeust , @make_graph ).render
  end

  private

  def class_name_of_each_row
    ::TokyoMetro::App::Renderer::PassengerSurvey::Table::Year::Row
  end

  def variables_send_to_row_instance( passenger_survey_info , i )
    y = passenger_survey_info.survey_year
    super + [ @passenger_survey_infos.in_year(y) ]
  end

end