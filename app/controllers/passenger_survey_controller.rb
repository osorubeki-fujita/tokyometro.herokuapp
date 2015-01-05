class PassengerSurveyController < ApplicationController

  # require 'each_railway_line'
  # require 'marunouchi_line_branch'
  include EachRailwayLine
  include MarunouchiLineBranch

  # require 'each_station'
  include EachStation

  def index
    @title = "各駅の乗降客数"
    @railway_lines = RailwayLine.tokyo_metro.includes( :stations )
    @stations_of_railway_lines = ::Station.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )
    render 'passenger_survey/index'
  end

  def marunouchi_line
    each_railway_line( "M" , "m" )
  end

  def in_2011
    by_year( 2011 )
  end

  def in_2012
    by_year( 2012 )
  end

  def in_2013
    by_year( 2013 )
  end

  private

  def each_railway_line( *railway_line_name_codes , railway_line_name_ja: nil , railway_line_name_en: nil )
    @railway_lines , @railway_lines_including_branch = [ RailwayLine.tokyo_metro , RailwayLine.tokyo_metro_including_branch ].map { | railway_lines |
      railway_lines.select_by_railway_line_codes( railway_line_name_codes ).includes( :stations )
    }

    @title = @railway_lines.map { | railway_line | railway_line.name_ja }.join( "・" ) + " 各駅の乗降客数"

    # Helper で定義
    @survey_year = ::ApplicationHelper.latest_passenger_survey_year

    # 設定された年・路線のデータを取得し、乗降人員が多い順に並び替える。
    @list_of_passenger_surveys = PassengerSurvey.list_of_a_railway_line( survey_year: @survey_year , railway_lines: @railway_lines_including_branch ).includes( :stations )

    @type = :railway_line
    @make_graph = true
    render 'passenger_survey/each_railway_line'
  end

  def by_year( year_i )
    @year = year_i
    @title = "#{@year}年度 各駅の乗降客数"
    @list_of_passenger_surveys = PassengerSurvey.in_year( @year ).order( passenger_journey: :desc ).includes( :stations )
    @type = :year
    @make_graph = true
    render 'passenger_survey/by_year'
  end

  def each_station( station_name )
    each_station_sub( "駅 各年度の乗降客数" , "passenger_survey" , station_name )
  end

end