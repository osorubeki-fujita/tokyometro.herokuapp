class TokyoMetro::App::Renderer::PassengerSurvey::Table::Station < TokyoMetro::App::Renderer::PassengerSurvey::Table::MetaClass

  def initialize( request , passenger_survey_infos , make_graph , passenger_survey_infos_all )
    super( request , passenger_survey_infos , make_graph )

    @passenger_survey_infos_all = passenger_survey_infos_all

    @css_class_name_of_tables = :station
  end

  def render_header_of_table
    ::TokyoMetro::App::Renderer::PassengerSurvey::Table::Station::Header.new( @reqeust , @make_graph ).render
  end

  private

  def class_name_of_each_row
    ::TokyoMetro::App::Renderer::PassengerSurvey::Table::Station::Row
  end

  def variables_send_to_row_instance( passenger_survey_info , i )
    super + [ @passenger_survey_infos_all ]
  end

end