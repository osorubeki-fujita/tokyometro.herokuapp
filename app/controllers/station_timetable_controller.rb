class StationTimetableController < ApplicationController

  include EachRailwayLine
  include YurakuchoAndFukutoshinLine
  include MarunouchiLineBranch

  include EachStation

  def index
    @title = "駅の時刻表"
    @railway_lines = ::RailwayLine.tokyo_metro
    @station_infos_of_railway_lines = ::Station::Info.tokyo_metro
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
      station_info_ids = @station_info.station_infos_including_other_railway_lines.pluck( :id )
      station_timetable_ids = ::StationTimetableFundamentalInfo.where( station_info_id: station_info_ids ).pluck( :station_timetable_id )
      @station_timetables = ::StationTimetable.where( id: station_timetable_ids ).includes(
        :station_train_times ,
        :station_timetable_fundamental_infos
      )
      @railway_lines = ::RailwayLine.where( id: ::Station::Info.where( id: station_info_ids ).pluck( :railway_line_id ).uniq.sort )
    end
  end

end