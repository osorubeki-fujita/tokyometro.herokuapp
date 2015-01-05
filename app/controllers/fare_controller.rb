class FareController < ApplicationController

  # require 'each_railway_line'
  # require 'marunouchi_line_branch'
  # include EachRailwayLine
  # include MarunouchiLineBranch

  # require 'each_station'
  include EachStation

  def index
    @title = "運賃のご案内"
    @railway_lines = RailwayLine.tokyo_metro.includes( :stations )
    @stations_of_railway_lines = ::Station.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )
    render( 'fare/index' , layout: 'application' )
  end

  def each_station( station_name )
    each_station_sub( "駅発着の運賃のご案内" , "fare" , station_name ) do
      @normal_fare_groups = ::NormalFareGroup.all
    end
  end

end