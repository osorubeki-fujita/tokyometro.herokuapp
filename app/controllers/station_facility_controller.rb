class StationFacilityController < ApplicationController

  include EachRailwayLine
  include EachStation
  include YurakuchoAndFukutoshinLine

  def index
    @title = "駅のご案内"
    @railway_lines = ::RailwayLine.tokyo_metro
    @station_infos_of_railway_lines = ::Station::Info.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )

    render 'station_facility/index'
  end

  private

  def each_railway_line( *railway_lines_same_as )
    each_railway_line_sub( "駅のご案内" , "station_facility" , *railway_lines_same_as , with_branch: true , layout: "application_wide" )
  end

  def each_station( station_info_same_as )
    each_station_sub( "駅のご案内" , "station_facility" , station_info_same_as , layout: "application_wide" ) do
      @station_facility = @station_info.station_facility
      @railway_lines = ::RailwayLine.where( id: @station_facility.station_infos.pluck( :railway_line_id ) ).tokyo_metro.except_for_branch_lines
      @display_google_map = true

      @points = @station_facility.points.includes( :point_category )

      set_station_info_for_google_map
      set_exit_info_for_google_map
    end
  end

  def set_station_info_for_google_map
    @station_info_for_google_map = Gmaps4rails.build_markers( @station_facility.station_infos ) do | station_info , marker |
      marker.lat( station_info.latitude )
      marker.lng( station_info.longitude )
      marker.infowindow( "#{ station_info.name_ja }（#{ station_info.railway_line.name_ja }）" )
      marker.json( { title: station_info.name_ja } )
    end
  end

  def set_exit_info_for_google_map
    @exit_info_for_google_map = Gmaps4rails.build_markers( @points ) do | point , marker |
      info_window_ja = String.new
      info_window_en = String.new
      if point.closed
        info_window_ja << "【現在閉鎖中】"
        info_window_en << "【Closed】"
      end
      info_window_ja << "#{point.point_category.name_ja} #{point.code}"
      info_window_en << "(Exit #{point.code})"
      if point.elevator.present?
        info_window_ja << "（エレベーターあり）"
        info_window_en << " (With an elevator)"
      end
      if point.additional_info.present?
        info_window_ja << "（#{point.additional_info}）"
      end

      marker.lat( point.latitude )
      marker.lng( point.longitude )
      marker.infowindow( [ info_window_ja , info_window_en ].join( " " ) )
      json_title = @station_info.name_ja  + " " + @station_info.name_en
      marker.json( { title: json_title } )
    end
  end

end