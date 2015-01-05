class StationTimetableController < ApplicationController

  # require 'each_railway_line'
  # require 'yurakucho_and_fukutoshin_line'
  # require 'marunouchi_line_branch'
  include EachRailwayLine
  include YurakuchoAndFukutoshinLine
  include MarunouchiLineBranch

  # require 'each_station'
  include EachStation

  def index
    @title = "駅の時刻表"
    @railway_lines = RailwayLine.tokyo_metro.includes( :stations )
    @stations_of_railway_lines = ::Station.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )
    render 'station_timetable/index'
  end

  private

  def each_railway_line( *railway_line_name_codes )
    each_railway_line_sub( "各駅の時刻表" , "station_timetable" , *railway_line_name_codes , with_branch: true )
  end

  def each_station( station_name )
    each_station_sub( "駅の時刻表" , "station_timetable" , station_name , layout: "application_wide" ) do
      station_ids = @station.station_facility.stations.pluck( :id )
      @timetables = ::Timetable.where( station_id: station_ids ).includes( :railway_line , :operator , :railway_direction , :train_times , train_times: [ :to_station , :train_type ] )
      @railway_lines = ::RailwayLine.find( ::Station.where( id: station_ids ).pluck( :railway_line_id ).uniq.sort )
    end
  end

end