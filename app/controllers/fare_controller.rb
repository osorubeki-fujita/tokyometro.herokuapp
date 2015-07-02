class FareController < ApplicationController

  include ActionBaseForStationPage
  include RailwayLineByParams

  include TwitterProcessor

  def index
    @title = "運賃のご案内"
    @railway_lines = RailwayLine.tokyo_metro
    @station_infos_of_railway_lines = ::Station::Info.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )
    set_twitter_processor( :tokyo_metro )
    render( 'fare/index' , layout: 'application' )
  end

  def action_for_station_page
    action_base_for_station_page( :fare ) do
      set_railway_line_of_terminal_station_in_station_page
      set_twitter_processor( railway_lines: @station_info.railway_lines_of_tokyo_metro )
    end
  end

  private

  def base_of_station_page_title
    "発着の運賃のご案内"
  end

  def set_railway_line_of_terminal_station_in_station_page
    @railway_line_of_terminal_station = railway_line_by_params( branch_railway_line: :main_and_branch , use_station_info: true )
  end

end