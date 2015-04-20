class TokyoMetro::App::Renderer::PassengerSurvey::Table::RailwayLine < TokyoMetro::App::Renderer::PassengerSurvey::Table::MetaClass

  def initialize( request , passenger_survey_infos_of_the_same_railway_line , make_graph , railway_lines_including_branch , passenger_survey_infos_of_the_same_operator )
    super( request , passenger_survey_infos_of_the_same_railway_line , make_graph )

    @railway_lines_including_branch = railway_lines_including_branch
    @passenger_survey_infos_of_the_same_operator = passenger_survey_infos_of_the_same_operator

    raise "Error" unless @railway_lines_including_branch.present?
    @css_class_name_of_tables = @railway_lines_including_branch.first.css_class_name
  end

  def render_header_of_table
    ::TokyoMetro::App::Renderer::PassengerSurvey::Table::RailwayLine::Header.new( @reqeust , @make_graph , main_railway_line ).render
  end

  private

  def class_name_of_each_row
    ::TokyoMetro::App::Renderer::PassengerSurvey::Table::RailwayLine::Row
  end

  def variables_send_to_row_instance( passenger_survey_info , i )
    super + [ passenger_survey_infos_of_the_same_railway_line , @passenger_survey_infos_of_the_same_operator , @railway_lines_including_branch ]
  end

  def passenger_survey_infos_of_the_same_railway_line
    @passenger_survey_infos
  end
  
  def main_railway_line
    [ @railway_lines_including_branch ].flatten.select { | item | !( item.is_branch_railway_line? ) }.first
  end

end