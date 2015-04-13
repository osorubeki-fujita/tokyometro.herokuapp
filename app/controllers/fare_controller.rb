class FareController < ApplicationController

  # include EachStation
  include ActionBaseForStationPage

  def index
    @title = "運賃のご案内"
    @railway_lines = RailwayLine.tokyo_metro
    @station_infos_of_railway_lines = ::Station::Info.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )
    render( 'fare/index' , layout: 'application' )
  end

  def action_for_station_page
    action_base_for_station_page( :fare ) do
      set_railway_line_of_terminal_station_in_station_page
    end
  end

  private

  def base_of_station_page_title
    "発着の運賃のご案内"
  end

  def set_railway_line_of_terminal_station_in_station_page
    @railway_line_of_terminal_station = railway_line_by_params( branch_railway_line: :main_and_branch )
  end

end