class StationTimetableController < ApplicationController

  include ActionBaseForStationPage
  include ActionBaseForRailwayLinePage
  include RailwayLineByParams

  include TwitterProcessor

  def index
    @title = "駅の時刻表"
    @railway_line_infos = ::Railway::Line::Info.tokyo_metro
    @station_infos_of_railway_line_infos = ::Station::Info.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_line_infos )
    set_twitter_processor( :tokyo_metro )
    render 'station_timetable/index'
  end

  def action_for_station_page
    action_base_for_station_page( :station_timetable , layout: :application_wide ) do
      set_railway_line_for_station_page
      set_station_timetable_infos
      set_railway_line_infos_for_station_page
    end
  end

  def action_for_railway_line_page
    action_base_for_railway_line_page( :station_timetable , layout: :application ) do
      set_twitter_processor
    end
  end

  private

  def set_railway_line_infos_of_railway_line_page_by_params
    @railway_line_infos = railway_line_by_params( branch_railway_line_info: :main_and_branch , yurakucho_and_fukutoshin: true )
  end

  def base_of_railway_line_page_title
    " 各駅の時刻表"
  end

  def base_of_station_page_title
    railway_line_name = [ @railway_line_infos ].flatten.map( &:name_ja).join( "・" )
    "の時刻表（#{ railway_line_name }）"
  end

  def set_railway_line_for_station_page
    @railway_line_infos = [ railway_line_by_params( branch_railway_line_info: :no_process , use_station_info: true ) ].flatten
  end

  def station_info_ids
    @station_info.station_infos_including_other_railway_line_infos.pluck( :id )
  end

  def station_timetable_info_ids
    ::Station::Timetable::FundamentalInfo.where( station_info_id: station_info_ids , railway_line_info_id: @railway_line_infos.map( &:id ) ).pluck( :info_id )
  end

  def railway_line_info_ids_of_this_station
    ::Station::Info.where( id: station_info_ids ).pluck( :railway_line_info_id ).uniq.sort
  end

  def set_railway_line_infos_for_station_page
    @railway_line_infos = ::Railway::Line::Info.where( id: railway_line_info_ids_of_this_station )
  end

  def set_station_timetable_infos
    @station_timetable_infos = ::Station::Timetable::Info.where( id: station_timetable_info_ids ).includes( :station_train_times , :fundamental_infos )
  end

end
