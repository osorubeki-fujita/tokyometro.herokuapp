class StationTimetableController < ApplicationController

  include ActionBaseForStationPage
  include ActionBaseForRailwayLinePage
  include RailwayLineByParams
  
  include TwitterProcessor

  def index
    @title = "駅の時刻表"
    @railway_lines = ::RailwayLine.tokyo_metro
    @station_infos_of_railway_lines = ::Station::Info.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )
    set_twitter_processor( :tokyo_metro )
    render 'station_timetable/index'
  end

  def action_for_station_page
    action_base_for_station_page( :station_timetable , layout: :application_wide ) do
      set_railway_line_for_station_page
      set_station_timetables
      set_railway_lines_for_station_page
    end
  end

  def action_for_railway_line_page
    action_base_for_railway_line_page( :station_timetable , layout: :application ) do
      set_twitter_processor
    end
  end

  private
  
  def set_railway_lines_of_railway_line_page_by_params
    @railway_lines = railway_line_by_params( branch_railway_line: :main_and_branch , yurakucho_and_fukutoshin: true )
  end
  
  def base_of_railway_line_page_title
    " 各駅の時刻表"
  end

  def base_of_station_page_title
    railway_line_name = [ @railway_line ].flatten.map( &:name_ja).join( "・" )
    "の時刻表（#{ railway_line_name }）"
  end

  def set_railway_line_for_station_page
    @railway_line = railway_line_by_params( branch_railway_line: :no_process , use_station_info: true )
  end

  def station_info_ids
    @station_info.station_infos_including_other_railway_lines.pluck( :id )
  end

  def station_timetable_ids
    ::StationTimetableFundamentalInfo.where( station_info_id: station_info_ids , railway_line_id: @railway_line.id ).pluck( :station_timetable_id )
  end

  def railway_line_ids_of_this_station
    ::Station::Info.where( id: :station_info_ids ).pluck( :railway_line_id ).uniq.sort
  end

  def set_railway_lines_for_station_page
    @railway_lines = ::RailwayLine.where( id: railway_line_ids_of_this_station )
  end

  def set_station_timetables
    @station_timetables = ::StationTimetable.where( id: station_timetable_ids ).includes( :station_train_times , :station_timetable_fundamental_infos )
  end

end