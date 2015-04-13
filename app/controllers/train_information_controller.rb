class TrainInformationController < ApplicationController

  include AjaxUpdate
  include EachStation
  include EachRailwayLine

  def index
    @title = "各線の列車運行情報"
    @railway_lines = ::RailwayLine.tokyo_metro
    @station_infos_of_railway_lines = ::Station::Info.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )
    render 'train_information/index'
  end

  private

  def each_railway_line( *railway_lines_same_as )
    each_railway_line_sub( "列車運行情報" , "train_information" , *railway_lines_same_as , with_branch: true )
  end

  def each_station( station_info_same_as )
    each_station_sub( "駅からの列車運行情報" , "train_information" , station_info_same_as )
  end

end