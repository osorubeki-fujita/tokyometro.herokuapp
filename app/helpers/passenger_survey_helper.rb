module PassengerSurveyHelper

  # タイトルを記述するメソッド（路線別）
  def passenger_survey_title_of_grouped_by_line
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( :railway_line )
  = railway_line_name_main( railway_lines )
    HAML
  end

  # タイトルを記述するメソッド（年度別）
  def passenger_survey_title_grouped_by_year
    render inline: <<-HAML , type: :haml , locals: { year: @year }
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( :year )
  = ::PassengerSurveyDecorator.render_year_in_title( year )
    HAML
  end

  def passenger_survey_title_of_each_station
    render inline: <<-HAML , type: :haml , locals: { station: @station }
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( :station )
  = @station.decorate.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def css_class_name_of_passenger_survey_table
    case @type
    when :year
      :tokyo_metro
    when :railway_line
      @railway_lines_including_branch.first.css_class_name
    when :station
      :station
    end
  end

  # Table を作成するメソッド
  def passenger_survey_table

    h_locals ={
      passenger_survey_infos: @passenger_survey_infos ,
      type: @type ,
      make_graph: @make_graph ,
      class_name: css_class_name_of_passenger_survey_table
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :passenger_survey_table , class: class_name }
  %table{ class: [ :table , "table-striped" ] }
    = ::PassengerSurveyDecorator.render_header_of_table( type , make_graph )
    = ::PassengerSurveyDecorator.render_body_of_table( passenger_survey_infos , type , make_graph )
    HAML
  end

  def passenger_survey_station_codes_in_table( stations )
    if @railway_lines_including_branch.blank?
      @railway_lines_including_branch = ::RailwayLine.tokyo_metro_including_branch
    end

    stations_displayed = stations.in_railway_line( @railway_lines_including_branch.map( &:id ).flatten )
    display_images_of_station_codes( stations_displayed , true )
  end

end