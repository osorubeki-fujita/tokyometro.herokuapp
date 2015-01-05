class TrainInformationController < ApplicationController

  # require 'ajax_update'
  # require 'each_railway_line'
  # require 'yurakucho_and_fukutoshin_line'
  # require 'each_station'

  include AjaxUpdate
  # include EachRailwayLine
  # include YurakuchoAndFukutoshinLine
  include EachStation

  def index
    @title = "各線の列車運行情報"
    @railway_lines = RailwayLine.tokyo_metro.includes( :stations )
    @stations_of_railway_lines = ::Station.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )
    render 'train_information/index'
  end

  private
=begin
  def each_railway_line( *railway_line_name_codes )
    each_railway_line_sub( "列車運行情報" , "train_information" , *railway_line_name_codes , with_branch: true )
  end
=end

  def each_station( station_name )
    each_station_sub( "駅からの列車運行情報" , "train_information" , station_name )
  end

end