class PassengerSurveyController < ApplicationController

  include ActionBaseForStationPage
  include RailwayLineByParams

  def index
    @title = "各駅の乗降客数"
    @railway_lines = ::RailwayLine.tokyo_metro
    @station_infos_of_railway_lines = ::Station::Info.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )
    render 'passenger_survey/index'
  end

  def action_for_railway_line_or_year_page
    @survey_year = survey_year
    if params[ :railway_line ].to_s == "all"
      action_for_year_page
    else
      action_for_railway_line_page
    end
  end

  def action_for_station_page
    action_base_for_station_page( :passenger_survey ) do
      @passenger_survey_infos = @station_info.passenger_surveys.order( survey_year: :desc )
      @passenger_survey_infos_all = ::PassengerSurvey.all.order( passenger_journeys: :desc )
      @make_graph = true
    end
  end

  private

  def action_for_year_page
    @title = "#{ @survey_year }年度 各駅の乗降客数"
    @passenger_survey_infos = ::PassengerSurvey.in_year( @survey_year ).order( passenger_journeys: :desc ).includes( :station_infos )
    @make_graph = true
    render 'passenger_survey/each_year'
  end

  def action_for_railway_line_page
    @railway_lines = [ railway_line_by_params( :railway_line , branch_railway_line: :exclude , use_station_info: false ) ].flatten
    @railway_lines_including_branch = [ railway_line_by_params( :railway_line , branch_railway_line: :main_and_branch , use_station_info: false ) ].flatten
    @title = @railway_lines.map( &:name_ja ).join( "・" ) + " 各駅の乗降客数（#{ @survey_year }年度）"

    # 設定された年・路線のデータを取得し、乗降人員が多い順に並び替える。
    @passenger_survey_infos_of_the_same_railway_line = ::PassengerSurvey.list_of_a_railway_line( survey_year: @survey_year , railway_lines: @railway_lines_including_branch ).includes( :station_infos )
    @passenger_survey_infos_of_the_same_operator = ::PassengerSurvey.in_year( @survey_year ).order( passenger_journeys: :desc )
    @make_graph = true
    render 'passenger_survey/each_railway_line'
  end
  
  def base_of_station_page_title
    " " + "各年度の乗降客数"
  end

  def survey_year
    if params[ :survey_year ].present?
      params[ :survey_year ].to_i
    else
      ::PassengerSurvey.latest_passenger_survey_year
    end
  end

end