class StationFacilityController < ApplicationController

  include ActionBaseForStationPage

  # include ActionBaseForRailwayLinePage
  # include RailwayLineByParams

  def index
    @title = "駅のご案内"
    @railway_lines = ::RailwayLine.tokyo_metro
    @station_infos_of_railway_lines = ::Station::Info.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )

    render 'station_facility/index'
  end

  def action_for_station_page
    action_base_for_station_page( :station_facility , layout: :application_wide ) do
      @station_facility = @station_info.station_facility
      @railway_lines = ::RailwayLine.where( id: @station_facility.station_infos.pluck( :railway_line_id ) ).tokyo_metro.except_for_branch_lines
      # @display_google_map = true

      @points = @station_facility.points.includes( :point_category )

      # set_station_info_for_google_map
      set_exit_info_for_google_map
    end
  end

=begin
  def action_for_railway_line_page
    action_base_for_railway_line_page( :station_facility , layout: :application_wide )
  end
=end

  private

  def base_of_station_page_title
    "のご案内"
  end

  def set_station_info_for_google_map
    @station_info_for_google_map = ::Gmaps4rails.build_markers( @station_facility.station_infos ) do | station_info , marker |
      marker.lat( station_info.latitude )
      marker.lng( station_info.longitude )
      marker.infowindow( "#{ station_info.decorate.name_ja_actual }（#{ station_info.railway_line.name_ja }）" )
      marker.json( { title: station_info.decorate.name_ja_actual } )
    end
  end

  def set_exit_info_for_google_map
    json_title = @station_info.decorate.json_title_on_google_map
    @exit_info_for_google_map = ::Gmaps4rails.build_markers( @points ) do | point , marker_of_this_station |
      point.set_to( marker_of_this_station , json_title )
    end
  end

=begin
  
  def set_railway_lines_of_railway_line_page_by_params
    @railway_lines = railway_line_by_params( branch_railway_line: :main_and_branch , yurakucho_and_fukutoshin: true )
  end

  def base_of_railway_line_page_title
    " 各駅のご案内"
  end

=end

end