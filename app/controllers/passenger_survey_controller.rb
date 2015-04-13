class PassengerSurveyController < ApplicationController

  include EachRailwayLine
  include MarunouchiLineBranch

  include EachStation

  def index
    @title = "各駅の乗降客数"
    @railway_lines = ::RailwayLine.tokyo_metro
    @station_infos_of_railway_lines = ::Station::Info.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )
    render 'passenger_survey/index'
  end

  def marunouchi_line
    each_railway_line( "odpt.Railway:TokyoMetro.Marunouchi" , "odpt.Railway:TokyoMetro.MarunouchiBranch" )
  end

  [ 2011 , 2012 , 2013 ].each do | year |
    eval <<-DEF
      def in_#{ year }
        by_year( #{year} )
      end
    DEF
  end

  private

  def each_railway_line( *railway_line_names , railway_line_name_ja: nil , railway_line_name_en: nil )
    @railway_lines , @railway_lines_including_branch = [
      ::RailwayLine.tokyo_metro( including_branch_line: false ) ,
      ::RailwayLine.tokyo_metro( including_branch_line: true )
    ].map { | railway_lines |
      railway_lines.select { | item | railway_line_names.include?( item.same_as ) }
    }

    @title = @railway_lines.map( &:name_ja ).join( "・" ) + " 各駅の乗降客数"

    # Helper で定義
    @survey_year = ::PassengerSurvey.latest_passenger_survey_year

    # 設定された年・路線のデータを取得し、乗降人員が多い順に並び替える。
    @passenger_survey_infos = ::PassengerSurvey.list_of_a_railway_line( survey_year: @survey_year , railway_lines: @railway_lines_including_branch ).includes( :station_infos )

    @type = :railway_line
    @make_graph = true
    render 'passenger_survey/each_railway_line'
  end

  def by_year( year_i )
    @year = year_i
    @title = "#{@year}年度 各駅の乗降客数"
    @passenger_survey_infos = ::PassengerSurvey.in_year( @year ).order( passenger_journeys: :desc ).includes( :station_infos )
    @type = :year
    @make_graph = true
    render 'passenger_survey/by_year'
  end

  def each_station( station_info_same_as )
    each_station_sub( "駅 各年度の乗降客数" , "passenger_survey" , station_info_same_as ) do
      @passenger_survey_infos = @station_info.passenger_surveys
      @type = :station
      @make_graph = true
    end
  end

end